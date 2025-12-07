import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

/// 创建橱柜对话框
class DialogCreateCabinet {
  /// 显示创建橱柜对话框
  static void show({
    required WarehouseHomeRouterData household,
    required List<WarehouseHomeRouterData> rooms,
    Function(String name, String? roomId, String? description)? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final context = RootRouterUtil.instance.rootContext;
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
  final Function(String name, String? roomId, String? description)? onConfirm;
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
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('未設定'),
      ),
      ...widget.rooms.map((room) {
        return DropdownMenuItem<String?>(
          value: room.id,
          child: Text(room.name),
        );
      }),
    ];

    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0.scale),
          padding: EdgeInsets.all(24.0.scale),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
          constraints: BoxConstraints(
            maxWidth: 600.0.scale,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title 居中
              Center(
                child: Text(
                  '新增櫥櫃',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: 24.0.scale),
              // 橱柜名称输入框
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '櫥櫃名稱',
                  hintText: '請輸入櫥櫃名稱',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0.scale),
              // 房间选择下拉选单
              DropdownButtonFormField<String?>(
                value: _selectedRoomId,
                decoration: const InputDecoration(
                  labelText: '房間',
                  border: OutlineInputBorder(),
                ),
                items: roomOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedRoomId = value;
                  });
                },
              ),
              SizedBox(height: 16.0.scale),
              // 描述输入框
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: '描述',
                  hintText: '請輸入描述（選填）',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24.0.scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCancel?.call();
                    },
                    child: const Text('取消'),
                  ),
                  SizedBox(width: 12.0.scale),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.trim();
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('請輸入櫥櫃名稱'),
                          ),
                        );
                        return;
                      }

                      final description = _descriptionController.text.trim();
                      Navigator.of(context).pop();
                      widget.onConfirm?.call(
                        name,
                        _selectedRoomId,
                        description.isEmpty ? null : description,
                      );
                    },
                    child: const Text('確認'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
