part of 'water_value_timer_list_page_controller.dart';

enum EnumWaterValueTimerListPageInteractive {
  tapBackButton,
  tapSettingButton,
  tapAddTimerButton,
  tapDeleteButton,
  tapToggleSwitch,
}

extension WaterValueTimerListPageInteractiveExtension on WaterValueTimerListPageController {
  void interactive(
    EnumWaterValueTimerListPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWaterValueTimerListPageInteractive.tapBackButton:
        _handleBackButton();
      case EnumWaterValueTimerListPageInteractive.tapSettingButton:
        _handleSettingButton();
      case EnumWaterValueTimerListPageInteractive.tapAddTimerButton:
        _handleAddTimerButton();
      case EnumWaterValueTimerListPageInteractive.tapDeleteButton:
        if (data is String) {
          _handleDeleteButton(data);
        }
      case EnumWaterValueTimerListPageInteractive.tapToggleSwitch:
        if (data is String) {
          _handleToggleSwitch(data);
        }
    }
  }

  void _handleBackButton() {
    final callback = _model.routerData?.onBackButtonTap;
    if (callback != null) {
      callback();
    } else {
      routerHandle(EnumWaterValueTimerListPageRoute.pop);
    }
  }

  void _handleSettingButton() {
    // 切换编辑模式
    _model.isEditMode.value = !_model.isEditMode.value;

    final callback = _model.routerData?.onSettingButtonTap;
    if (callback != null) {
      callback();
    }
  }

  Future<void> _handleAddTimerButton() async {
    final callback = _model.routerData?.onAddTimer;
    if (callback != null) {
      await callback();
    } else {
      // 如果没有 callback，跳转到定时设定页面（新建模式）
      routerHandle(
        EnumWaterValueTimerListPageRoute.goToTimerSettingPage,
        data: const WaterValueTimerSettingPageRouterData(
          initialOpenTime: null,
          initialCloseTime: null,
          initialRepeatEnabled: false,
          initialNotificationEnabled: false,
          initialSelectedWeekday: 0,
          initialSelectedTab: 0,
          initialSelectedDays: null,
        ),
      );
    }
  }

  Future<void> _handleDeleteButton(String itemId) async {
    final callback = _model.routerData?.onDeleteTimer;
    if (callback != null) {
      await callback(itemId);
      // 从列表中移除
      final currentList = List<WaterValueTimerItem>.from(_model.timerItems.value);
      currentList.removeWhere((item) => item.id == itemId);
      _model.timerItems.value = currentList;
    }
  }

  Future<void> _handleToggleSwitch(String itemId) async {
    final currentList = _model.timerItems.value;
    final item = currentList.firstWhereOrNull((item) => item.id == itemId);
    if (item == null) return;

    final newEnabled = !item.isEnabled;

    // 更新本地状态
    final index = currentList.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      final updatedList = List<WaterValueTimerItem>.from(currentList);
      updatedList[index] = WaterValueTimerItem(
        id: item.id,
        name: item.name,
        openTime: item.openTime,
        closeTime: item.closeTime,
        isRepeatEnabled: item.isRepeatEnabled,
        selectedWeekday: item.selectedWeekday,
        selectedDays: item.selectedDays,
        isNotificationEnabled: item.isNotificationEnabled,
        note: item.note,
        isEnabled: newEnabled,
      );
      _model.timerItems.value = updatedList;
    }

    final callback = _model.routerData?.onToggleTimer;
    if (callback != null) {
      await callback(itemId, newEnabled);
    }
  }
}
