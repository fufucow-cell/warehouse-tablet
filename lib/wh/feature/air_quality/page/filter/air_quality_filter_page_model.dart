import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityFilterPageModel {
  AirQualityFilterPageRouterData? routerData;
  final TextEditingController filterLifeDaysController = TextEditingController();
  final isEditing = false.obs;
  int? _tempValue; // 临时值，用于取消时恢复

  int get filterLifeDays => routerData?.lifeDays ?? 1;

  void initFromRouterData() {
    if (routerData != null) {
      filterLifeDaysController.text = routerData!.lifeDays.toString();
    }
  }

  void startEditing() {
    _tempValue = filterLifeDays;
    isEditing.value = true;
  }

  void confirmEditing() {
    final value = int.tryParse(filterLifeDaysController.text);
    if (value != null && value > 0 && routerData != null) {
      routerData!.onlifeDaysChanged(value);
      isEditing.value = false;
      _tempValue = null;
    } else {
      // 如果输入无效，恢复临时值
      cancelEditing();
    }
  }

  void cancelEditing() {
    if (_tempValue != null) {
      filterLifeDaysController.text = _tempValue.toString();
    }
    isEditing.value = false;
    _tempValue = null;
  }

  void onReset() {
    if (routerData != null) {
      routerData!.onFilterReset();
    }
  }

  void dispose() {
    filterLifeDaysController.dispose();
  }
}

class AirQualityFilterPageRouterData {
  final int lifeDays;
  final int lifePercent;
  final void Function(int days) onlifeDaysChanged;
  final VoidCallback onFilterReset;
  final VoidCallback onBackButtonTap;

  const AirQualityFilterPageRouterData({
    required this.lifeDays,
    required this.lifePercent,
    required this.onlifeDaysChanged,
    required this.onFilterReset,
    required this.onBackButtonTap,
  });
}
