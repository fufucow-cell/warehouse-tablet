import 'package:flutter/material.dart';

enum EnumFontWeightType {
  regular,
  medium,
  semibold,
  bold;

  FontWeight get weight {
    return switch (this) {
      EnumFontWeightType.regular => FontWeight.w400,
      EnumFontWeightType.medium => FontWeight.w500,
      EnumFontWeightType.semibold => FontWeight.w600,
      EnumFontWeightType.bold => FontWeight.w700,
    };
  }
}
