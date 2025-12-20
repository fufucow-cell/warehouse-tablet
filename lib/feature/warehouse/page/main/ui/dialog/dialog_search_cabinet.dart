import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';

/// 櫥櫃搜索对话框
class DialogSearchCabinet {
  /// 显示櫥櫃搜索对话框
  static void show({
    String? initialName,
    String? initialRoomId,
    Function({
      String? name,
      String? roomId,
    })? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final context = TempRouterUtil.getRootContext();
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _SearchCabinetDialogWidget(
        initialName: initialName,
        initialRoomId: initialRoomId,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 櫥櫃搜索对话框 Widget
class _SearchCabinetDialogWidget extends StatefulWidget {
  final String? initialName;
  final String? initialRoomId;
  final Function({
    String? name,
    String? roomId,
  })? onConfirm;
  final VoidCallback? onCancel;

  const _SearchCabinetDialogWidget({
    this.initialName,
    this.initialRoomId,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_SearchCabinetDialogWidget> createState() =>
      _SearchCabinetDialogWidgetState();
}

class _SearchCabinetDialogWidgetState
    extends State<_SearchCabinetDialogWidget> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedRoomId;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _selectedRoomId = widget.initialRoomId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取房间数据
    final service = WarehouseService.instance;
    final rooms = service.rooms
        .map(
          (room) => WarehouseHomeRouterData(
            id: room.id ?? '',
            name: room.name ?? '',
          ),
        )
        .toList();

    final dialogInsetPadding = 30.0.scale > 0 ? 30.0.scale : 30.0;
    return Dialog(
      insetPadding: EdgeInsets.all(dialogInsetPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final scale600 = 600.0.scale;
          final scale60 = 60.0.scale;
          final scale40 = 40.0.scale;
          final scale8 = 8.0.scale;
          final dialogMaxWidth = scale600 > 0 ? scale600 : 600.0;
          final insetPaddingValue = scale60 > 0 ? scale60 : 60.0;
          final containerPaddingValue = scale40 > 0 ? scale40 : 40.0;
          final horizontalPaddingValue = scale8 > 0 ? scale8 : 8.0;
          final screenMinusPadding = screenWidth - (insetPaddingValue * 2);
          final dialogWidth = (dialogMaxWidth < screenMinusPadding)
              ? dialogMaxWidth
              : screenMinusPadding;
          final maxHeight = MediaQuery.of(context).size.height * 0.8;
          return Container(
            width: dialogWidth,
            padding: EdgeInsets.all(containerPaddingValue),
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: maxHeight,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title 居中
                  Center(
                    child: Text(
                      EnumLocale.searchTitle.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // 名稱輸入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: EnumLocale.searchName.tr,
                        hintText: EnumLocale.searchNameHintCabinet.tr,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 所屬房間下拉選單
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: DropdownButtonFormField<String?>(
                      value: _selectedRoomId,
                      decoration: InputDecoration(
                        labelText: EnumLocale.searchRoom.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(EnumLocale.optionAll.tr),
                        ),
                        // 未設定選項（用特殊值標記）
                        DropdownMenuItem<String?>(
                          value: '__UNSET__',
                          child: Text(
                            EnumLocale.optionNotSet.tr,
                          ),
                        ),
                        // 其他房间选项
                        ...rooms.map((room) {
                          return DropdownMenuItem<String?>(
                            value: room.id,
                            child: Text(room.name),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRoomId = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onCancel?.call();
                          },
                          child: Text(
                            EnumLocale.commonCancel.tr,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onConfirm?.call(
                              name: _nameController.text.trim().isEmpty
                                  ? null
                                  : _nameController.text.trim(),
                              roomId: _selectedRoomId,
                            );
                          },
                          child: Text(
                            EnumLocale.commonConfirm.tr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
