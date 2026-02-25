import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityFilterPageModel {
  AirQualityFilterPageRouterData? routerData;
  int tempLifeDays = 0;
  final isEditing = false.obs;
  final isReset = false.obs;
}

class AirQualityFilterPageRouterData {
  final int lifeDays;
  final int lifePercent;
  final void Function(int days) onlifeDaysChanged;
  final VoidCallback onFilterReset;

  const AirQualityFilterPageRouterData({
    required this.lifeDays,
    required this.lifePercent,
    required this.onlifeDaysChanged,
    required this.onFilterReset,
  });
}
