import 'dart:io';

import 'package:camera/camera.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/device_service/device_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_snack_bar.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DeviceService extends GetxService {
  // MARK: - Properties

  final _model = DeviceServiceModel();
  bool get getIsSupportedDevice => _model.isSupportedDevice;
  double get getMinScale => _model.minScale;
  double get getScaleWidthValue => _model.scaleWidth;
  double get getScaleHeightValue => _model.scaleHeight;
  static DeviceService get instance => Get.find<DeviceService>();

  // MARK: - Init

  DeviceService._internal();

  static DeviceService register(BuildContext context) {
    if (Get.isRegistered<DeviceService>()) {
      return Get.find<DeviceService>();
    }
    final DeviceService service = DeviceService._internal();
    Get.put<DeviceService>(service, permanent: true);
    service._initDeviceInfo(context);
    service._initSimulatorCheck();
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<DeviceService>()) {
      Get.delete<DeviceService>(force: true);
    }
  }

  // MARK: - Public Method

  /// 是否為模擬器
  bool get isSimulator {
    if (_model.isWeb || _model.isDesktop) {
      return false;
    }
    if (_model.isIOS) {
      // 如果缓存已初始化，直接返回
      if (_model.isSimulatorCache != null) {
        return _model.isSimulatorCache!;
      }
      // 否则使用回退检测方法（同步）
      return _checkIOSSimulatorFallback();
    } else if (_model.isAndroid) {
      return _model.systemVersion.toLowerCase().contains('sdk') ||
          _model.systemVersion.toLowerCase().contains('emulator') ||
          Platform.environment.containsKey('ANDROID_EMULATOR');
    }
    return false;
  }

  Future<String?> openCameraChoise() async {
    // 如果是模擬器，顯示提示並返回
    if (isSimulator) {
      CustSnackBar.show(
        title: EnumLocale.deviceCameraNotAvailable.tr,
        message: '',
      );
      return null;
    }

    // 如果是 Android 平板，顯示選擇器讓用戶選擇相機或相簿
    if (_model.isAndroid) {
      final context = RouterService.instance.getRootNavigatorContext;
      if (context != null) {
        final ImageSource? selectedSource = await showModalBottomSheet<ImageSource>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => _ImageSourceBottomSheet(),
        );

        if (selectedSource == ImageSource.camera) {
          final result = await _takePhoto();
          return result?.path;
        } else if (selectedSource == ImageSource.gallery) {
          return await _pickImage(ImageSource.gallery);
        }

        return null;
      }
    }

    // 非 Android 平板直接打開相機
    return await _pickImage(ImageSource.camera);
  }

  Future<XFile?> _takePhoto() async {
    final context = RouterService.instance.getRootNavigatorContext;
    try {
      final cameras = await _availableCameras();

      if (cameras.isEmpty) {
        CustSnackBar.show(
          title: EnumLocale.deviceCameraNotAvailable.tr,
          message: '',
        );
        return null;
      }

      final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final result = await Navigator.push<XFile>(
        context!,
        MaterialPageRoute(
          builder: (context) => _CameraPage(camera: camera),
        ),
      );

      return result;
    } on Object catch (e) {
      CustSnackBar.show(
        title: EnumLocale.deviceCameraFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  Future<String?> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image == null) {
        return null;
      }

      // 確保文件路徑有效
      final String imagePath = image.path;
      if (imagePath.isEmpty) {
        return null;
      }

      // 使用 microtask 確保相機界面完全關閉後再繼續
      // 這可以確保相機資源釋放的時序正確，避免在拍照後立即處理圖片時出現相機停止運作的問題
      await Future.microtask(() {});

      // 等待一小段時間，確保相機資源完全釋放
      // 特別是在 iOS 設備或 Release 模式下，相機資源釋放可能需要更多時間
      await Future.delayed(const Duration(milliseconds: 500));

      // 驗證文件是否存在（確保文件已完全寫入）
      final File file = File(imagePath);
      if (!file.existsSync()) {
        return null;
      }

      return imagePath;
    } on PlatformException catch (e) {
      // 處理平台特定的異常（如權限被拒絕）
      final errorMessage = source == ImageSource.camera ? EnumLocale.deviceCameraFailed.tr : EnumLocale.deviceGalleryFailed.tr;
      CustSnackBar.show(
        title: errorMessage,
        message: e.message ?? e.toString(),
      );
      return null;
    } on Object catch (e) {
      final errorMessage = source == ImageSource.camera ? EnumLocale.deviceCameraFailed.tr : EnumLocale.deviceGalleryFailed.tr;
      CustSnackBar.show(
        title: errorMessage,
        message: e.toString(),
      );
      return null;
    }
  }

  Future<String?> openGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image?.path;
    } on Object catch (e) {
      CustSnackBar.show(
        title: EnumLocale.deviceGalleryFailed.tr,
        message: e.toString(),
      );
      return null;
    }
  }

  // MARK: - Private Method

  /// 初始化模擬器檢測（異步，使用平台通道）
  Future<void> _initSimulatorCheck() async {
    if (_model.isIOS && _model.isSimulatorCache == null) {
      try {
        const MethodChannel channel = MethodChannel('device_info');
        final bool? result = await channel.invokeMethod<bool>('isSimulator');
        if (result != null) {
          _model.isSimulatorCache = result;
          return;
        }
      } on Object catch (_) {}

      _model.isSimulatorCache = _checkIOSSimulatorFallback();
    }
  }

  /// 檢查 iOS 模擬器（回退方法，同步）
  bool _checkIOSSimulatorFallback() {
    // 回退检测方法
    return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME') ||
        Platform.environment.containsKey('SIMULATOR_ROOT') ||
        Platform.environment.containsKey('SIMULATOR_UDID') ||
        _model.systemVersion.toLowerCase().contains('simulator');
  }

  /// 獲取可用的相機列表
  Future<List<CameraDescription>> _availableCameras() async {
    try {
      return await availableCameras();
    } on Object catch (_) {
      return [];
    }
  }

  void _initDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // 存儲螢幕尺寸（邏輯像素）
    _model.screenSize = mediaQuery.size;

    // 存儲設備像素比
    _model.devicePixelRatio = mediaQuery.devicePixelRatio;

    // 存儲螢幕物理解析度（物理像素）
    _model.physicalSize = Size(
      _model.screenSize.width * _model.devicePixelRatio,
      _model.screenSize.height * _model.devicePixelRatio,
    );

    // 存儲狀態列和底部安全區域高度
    _model.statusBarHeight = mediaQuery.padding.top;
    _model.bottomSafeAreaHeight = mediaQuery.padding.bottom;

    // 存儲螢幕方向
    _model.isPortrait = mediaQuery.orientation == Orientation.portrait;

    // 判斷是否為平板或手機設備（平板通常最短邊 >= 600）
    if (!_model.isWeb && !_model.isDesktop && (_model.isIOS || _model.isAndroid)) {
      _model.isTablet = _model.physicalSize.shortestSide >= 600;
      _model.isIPad = _model.isIOS && _model.isTablet;
      _model.isAndroidPad = _model.isAndroid && _model.isTablet;
      _model.isMobile = !_model.isTablet;
      _model.isIPhone = _model.isIOS && _model.isMobile;
      _model.isAndroidPhone = _model.isAndroid && _model.isMobile;
    }

    // 計算設計與實機寬高比（先判斷平板，再判斷手機）
    if (_model.isTablet) {
      const deviceType = EnumSupportedDevice.tablet;
      _model.scaleWidth = _model.screenSize.width / deviceType.designWidth;
      _model.scaleHeight = _model.screenSize.height / deviceType.designHeight;
    } else if (_model.isMobile) {
      const deviceType = EnumSupportedDevice.mobile;
      _model.scaleWidth = _model.screenSize.width / deviceType.designWidth;
      _model.scaleHeight = _model.screenSize.height / deviceType.designHeight;
    }

    // 計算最小比例
    _model.minScale = _model.scaleWidth < _model.scaleHeight ? _model.scaleWidth : _model.scaleHeight;

    // 確認產品是否支援該裝置
    _model.isSupportedDevice = (_model.isTablet || _model.isMobile) && _model.minScale != 0.0;

    // double_extension.dart 參數設置
    scaleMin = _model.minScale;
    scaleWidth = _model.scaleWidth; // Top-level variable from extension_double.dart
    scaleHeight = _model.scaleHeight; // Top-level variable from extension_double.dart
  }
}

/// 圖片來源選擇底部選擇器（用於 Android 平板）
class _ImageSourceBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.0.scale,
        right: 24.0.scale,
        top: 24.0.scale,
        bottom: 32.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.engoBottomSheetBackground.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0.scale),
          topRight: Radius.circular(24.0.scale),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustTextWidget(
            EnumLocale.commonReminder.tr,
            size: 40.0.scale,
            weightType: EnumFontWeightType.bold,
            color: EnumColor.engoTextPrimary.color,
            align: TextAlign.center,
          ),
          SizedBox(height: 32.0.scale),
          _OptionItem(
            text: EnumLocale.deviceOpenCamera.tr,
            onTap: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
          ),
          SizedBox(height: 16.0.scale),
          Divider(
            height: 1.0.scale,
            thickness: 1.0.scale,
            color: EnumColor.textSecondary.color,
          ),
          SizedBox(height: 16.0.scale),
          _OptionItem(
            text: EnumLocale.deviceOpenGallery.tr,
            onTap: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
          ),
          SizedBox(height: 32.0.scale),
          Material(
            color: EnumColor.engoButtonBackground.color,
            borderRadius: BorderRadius.circular(12.0.scale),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(12.0.scale),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 24.0.scale,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0.scale,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(12.0.scale),
                ),
                child: Center(
                  child: CustTextWidget(
                    EnumLocale.commonCancel.tr,
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.regular,
                    color: EnumColor.engoTextPrimary.color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _OptionItem({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.scale),
            child: CustTextWidget(
              text,
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
      ),
    );
  }
}

class _CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const _CameraPage({required this.camera});

  @override
  State<_CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<_CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_isTakingPicture) {
      return;
    }

    try {
      setState(() => _isTakingPicture = true);

      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      if (mounted) {
        Navigator.pop(context, image);
      }
    } on Object catch (e) {
      if (mounted) {
        CustSnackBar.show(
          title: EnumLocale.deviceTakePhotoFailed.tr,
          message: e.toString(),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTakingPicture = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _isTakingPicture ? null : _takePicture,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: _isTakingPicture
                            ? const Padding(
                                padding: EdgeInsets.all(15),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 3,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
