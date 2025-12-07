import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/main/warehouse_main_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter_smart_home_tablet/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/util/root_router_util.dart';

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
    final context = RootRouterUtil.instance.rootContext;
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
                  '搜尋',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: 24.0.scale),
              // 名稱輸入框
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '名稱',
                  hintText: '請輸入櫥櫃名稱',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0.scale),
              // 所屬房間下拉選單
              DropdownButtonFormField<String?>(
                value: _selectedRoomId,
                decoration: const InputDecoration(
                  labelText: '所屬房間',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('全部'),
                  ),
                  // 未設定選項（用特殊值標記）
                  const DropdownMenuItem<String?>(
                    value: '__UNSET__',
                    child: Text('未設定'),
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
                      Navigator.of(context).pop();
                      widget.onConfirm?.call(
                        name: _nameController.text.trim().isEmpty
                            ? null
                            : _nameController.text.trim(),
                        roomId: _selectedRoomId,
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
