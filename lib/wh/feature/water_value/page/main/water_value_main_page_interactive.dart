part of 'water_value_main_page_controller.dart';

enum EnumWaterValueMainPageInteractive {
  tapBackButton,
  tapEditButton,
  tapSettingButton,
  tapSwitchToggle,
  tapCloseButton,
  tapOpenButton,
  tapTimerButton,
}

extension WaterValueMainPageUserEventExtension on WaterValueMainPageController {
  void interactive(
    EnumWaterValueMainPageInteractive type, {
    dynamic data,
  }) {
    switch (type) {
      case EnumWaterValueMainPageInteractive.tapBackButton:
        _handleBackButton();
      case EnumWaterValueMainPageInteractive.tapEditButton:
        _handleEditButton();
      case EnumWaterValueMainPageInteractive.tapSettingButton:
        _handleSettingButton();
      case EnumWaterValueMainPageInteractive.tapSwitchToggle:
        _handleSwitchToggle();
      case EnumWaterValueMainPageInteractive.tapCloseButton:
        _handleCloseButton();
      case EnumWaterValueMainPageInteractive.tapOpenButton:
        _handleOpenButton();
      case EnumWaterValueMainPageInteractive.tapTimerButton:
        _handleTimerButton();
    }
  }

  // MARK: - Private Method

  void _handleBackButton() {
    final callback = _model.routerData?.onBackButtonTap;
    if (callback != null) {
      callback();
    } else {
      routerHandle(EnumWaterValueMainPageRoute.pop);
    }
  }

  Future<void> _handleEditButton() async {
    final callback = _model.routerData?.onEditButtonTap;
    if (callback != null) {
      final newName = await callback(_model.title.value);
      if (newName != null && newName.isNotEmpty) {
        _model.title.value = newName;
      }
    }
  }

  void _handleSettingButton() {
    final callback = _model.routerData?.onSettingButtonTap;
    if (callback != null) {
      callback();
    }
  }

  Future<void> _handleSwitchToggle() async {
    final newValue = !_model.isSwitchOn.value;
    _model.isSwitchOn.value = newValue;

    final callback = _model.routerData?.onSwitchToggle;
    if (callback != null) {
      await callback(newValue);
    }
  }

  Future<void> _handleCloseButton() async {
    if (!_model.isSwitchOn.value) {
      return; // 已经是关闭状态
    }
    _model.isSwitchOn.value = false;

    final callback = _model.routerData?.onSwitchToggle;
    if (callback != null) {
      await callback(false);
    }
  }

  Future<void> _handleOpenButton() async {
    if (_model.isSwitchOn.value) {
      return; // 已经是开启状态
    }
    _model.isSwitchOn.value = true;

    final callback = _model.routerData?.onSwitchToggle;
    if (callback != null) {
      await callback(true);
    }
  }

  void _handleTimerButton() {
    final callback = _model.routerData?.onTimerButtonTap;
    if (callback != null) {
      callback();
    } else {
      // 如果没有 callback，跳转到定时列表页面
      routerHandle(
        EnumWaterValueMainPageRoute.goToTimerListPage,
        data: WaterValueTimerListPageRouterData(
          initialTimerItems: const [],
        ),
      );
    }
  }
}
