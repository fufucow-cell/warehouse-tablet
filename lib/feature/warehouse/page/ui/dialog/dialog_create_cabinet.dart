import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/temp_router_util.dart';

/// 创建橱柜对话框
class DialogCreateCabinet {
  /// 显示创建橱柜对话框
  static void show({
    required WarehouseHomeRouterData household,
    required List<WarehouseHomeRouterData> rooms,
    Function(
      String name,
      String? roomId,
      String? description,
    )? onConfirm,
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
      builder: (context) => _CreateCabinetDialogWidget(
        household: household,
        rooms: rooms,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }
}

/// 创建橱柜对话框 Widget
class _CreateCabinetDialogWidget extends StatefulWidget {
  final WarehouseHomeRouterData household;
  final List<WarehouseHomeRouterData> rooms;
  final Function(
    String name,
    String? roomId,
    String? description,
  )? onConfirm;
  final VoidCallback? onCancel;

  const _CreateCabinetDialogWidget({
    required this.household,
    required this.rooms,
    this.onConfirm,
    this.onCancel,
  });

  @override
  State<_CreateCabinetDialogWidget> createState() =>
      _CreateCabinetDialogWidgetState();
}

class _CreateCabinetDialogWidgetState
    extends State<_CreateCabinetDialogWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedRoomId;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 创建房间选项列表（第一个选项是"未設定"，然后是所有房间）
    final roomOptions = [
      DropdownMenuItem<String?>(
        value: null,
        child: Text(EnumLocale.optionNotSet.tr),
      ),
      ...widget.rooms.map((room) {
        return DropdownMenuItem<String?>(
          value: room.id,
          child: Text(room.name),
        );
      }),
    ];

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
                      EnumLocale.createCabinetTitle.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // 橱柜名称输入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: EnumLocale.createCabinetName.tr,
                        hintText: EnumLocale.createCabinetNameHint.tr,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 房间选择下拉选单
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: DropdownButtonFormField<String?>(
                      value: _selectedRoomId,
                      decoration: InputDecoration(
                        labelText: EnumLocale.createRoom.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: roomOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedRoomId = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 描述输入框
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPaddingValue,
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: EnumLocale.createDescription.tr,
                        hintText: EnumLocale.createDescriptionHint.tr,
                        border: const OutlineInputBorder(),
                      ),
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
                            final name = _nameController.text.trim();
                            if (name.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    EnumLocale.createCabinetInputName.tr,
                                  ),
                                ),
                              );
                              return;
                            }

                            final description =
                                _descriptionController.text.trim();
                            Navigator.of(context).pop();
                            widget.onConfirm?.call(
                              name,
                              _selectedRoomId,
                              description.isEmpty ? null : description,
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
