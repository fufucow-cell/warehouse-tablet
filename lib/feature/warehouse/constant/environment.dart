// 倉儲網域
enum EnumWarehouseInfo {
  dev,
  stg,
  uat,
  prd;

  String get baseUrl {
    switch (this) {
      case EnumWarehouseInfo.dev:
        return 'http://localhost:8000/api/v1/warehouse';
      // case EnumWarehouseInfo.stg:
      //     return 'https://warehouse-stg.example.com';
      // case EnumWarehouseInfo.uat:
      //     return 'https://warehouse-uat.example.com';
      // case EnumWarehouseInfo.prd:
      //     return 'https://warehouse.example.com';
      default:
        return 'http://localhost:8000/api/v1/warehouse';
    }
  }
}
