part of 'base_page_controller.dart';

class BasePageModel {
  int page = 1;
  int pageSize = 15;
  bool isPageActive = true;
  bool isShowScrollBackToTop = false;
  bool hasMoreData = true;
  final apiStatus = Rx<EnumBasePageCallApiStatus>(EnumBasePageCallApiStatus.waitInit);
  final isLoading = Rx<bool>(false);
  final isShowBackToTop = Rx<bool>(false);
  EnumBasePageScrollToTopStatus scrollButtonStatus = EnumBasePageScrollToTopStatus.dontShow;
}

enum EnumBasePageCallApiStatus {
  waitInit, // 初始化需要 call api
  firstCalling, // 初始化首次 call api
  reloading, // 重新 call api
  loadingMore, // 讀取有切分 page 與 pageSize 的資料
  success, // 成功
  fail, // 失敗
}

enum EnumBasePageScrollToTopStatus {
  dontShow,
  hide,
  show,
}
