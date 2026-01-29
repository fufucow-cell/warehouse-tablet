import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_rx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'air_quality_filter_page_interactive.dart';
part 'air_quality_filter_page_route.dart';

class AirQualityFilterPageController extends GetxController {
  // MARK: - Properties

  final _model = AirQualityFilterPageModel();
  AirQualityService get _service => AirQualityService.instance;
  TextEditingController get textController => _textController!;
  TextEditingController? _textController;
  int get filterLifePercent => isResetRx.value ? 100 : _model.routerData?.lifePercent ?? 0;
  RxReadonly<bool> get isEditingRx => _model.isEditing.readonly;
  RxReadonly<bool> get isResetRx => _model.isReset.readonly;

  // MARK: - Init

  AirQualityFilterPageController(AirQualityFilterPageRouterData routerData) {
    _model.routerData = routerData;
    _textController = TextEditingController(text: routerData.lifeDays.toString());
  }

  @override
  void onClose() {
    _textController?.dispose();
    super.onClose();
  }

  // MARK: - Private Method

  int get _getCurrentLifeDays {
    return int.tryParse(_textController?.text.trim() ?? '0') ?? 0;
  }

  void _dismissKeyboard() {
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null) {
      final focusContext = primaryFocus.context;

      if (focusContext != null) {
        if (focusContext.findAncestorWidgetOfExactType<TextField>() != null) {
          primaryFocus.unfocus();
        }
      } else {
        primaryFocus.unfocus();
      }
    }
  }
}
