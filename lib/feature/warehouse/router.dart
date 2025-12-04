import 'package:flutter_smart_home_tablet/feature/warehouse/page/alarm/warehouse_alarm_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/warehouse_cabinet_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/warehouse_category_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/item/warehouse_item_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/record/warehouse_record_page.dart';
import 'package:get/get.dart';

enum EnumWarehouseRouter {
  item,
  cabinet,
  category,
  reord,
  alarm;

  String get path {
    return 'warehouse_$name';
  }
}

class AppRouter {
  static List<GetPage<void>> getWarehousePages() {
    return [
      GetPage<void>(
        name: EnumWarehouseRouter.item.path,
        page: () => const WarehouseItemPage(),
      ),
      GetPage<void>(
        name: EnumWarehouseRouter.cabinet.path,
        page: () => const WarehouseCabinetPage(),
      ),
      GetPage<void>(
        name: EnumWarehouseRouter.category.path,
        page: () => const WarehouseCategoryPage(),
      ),
      GetPage<void>(
        name: EnumWarehouseRouter.reord.path,
        page: () => const WarehouseRecordPage(),
      ),
      GetPage<void>(
        name: EnumWarehouseRouter.alarm.path,
        page: () => const WarehouseAlarmPage(),
      ),
    ];
  }
}
