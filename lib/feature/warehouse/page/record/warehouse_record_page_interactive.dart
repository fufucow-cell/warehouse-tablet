part of 'warehouse_record_page.dart';

enum EnumWarehouseRecordPageInteractive {
  tapFilterButton,
}

extension WarehouseRecordPageUserEventExtension on WarehouseRecordPageController {
  void interactive(EnumWarehouseRecordPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseRecordPageInteractive.tapFilterButton:
        if (data is EnumFilterType) {
          _model.filterType.value = data;
          scrollController.jumpTo(0);
          _genVisibleLogs();
        }

        _model.isShowFilterMenu.value = !_model.isShowFilterMenu.value;
    }
  }
}
