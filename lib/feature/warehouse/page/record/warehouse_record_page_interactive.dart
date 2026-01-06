part of 'warehouse_record_page_controller.dart';

enum EnumWarehouseRecordPageInteractive {
  tapFilterButton,
  tapRefreshButton,
}

extension WarehouseRecordPageUserEventExtension on WarehouseRecordPageController {
  void interactive(EnumWarehouseRecordPageInteractive type, {dynamic data}) {
    switch (type) {
      case EnumWarehouseRecordPageInteractive.tapFilterButton:
        if (data is EnumFilterType) {
          _model.filterType.value = data;

          if (scrollController.hasClients && scrollController.offset > 0) {
            scrollController.jumpTo(0);
          }

          if (_model.allLogs.value != null) {
            _genVisibleLogs(_model.allLogs.value ?? []);
          }
        }

        _model.isShowFilterMenu.value = !_model.isShowFilterMenu.value;
      case EnumWarehouseRecordPageInteractive.tapRefreshButton:
        _queryApiData();
    }
  }
}
