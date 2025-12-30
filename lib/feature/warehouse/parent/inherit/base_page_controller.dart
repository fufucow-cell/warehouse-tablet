import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:get/get.dart';

part 'base_page_model.dart';

abstract class BasePageController extends GetxController {
  // MARK: - Properties

  final _model = BasePageModel();
  int get getPage => _model.page;
  int get getPageSize => _model.pageSize;
  bool get isLoading => _model.isLoading.value;
  Rx<bool> get isLoadingRx => _model.isLoading;
  bool get isShowBackToTop => _model.isShowBackToTop.value;
  EnumBasePageCallApiStatus get apiStatus => _model.apiStatus.value;
  ScrollController? scrollController;

  // MARK: - Init

  void init({
    bool needLoadMoreScroll = false,
    bool needShowBackToTop = false,
    bool isCallApiWhenInit = true,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.scrollButtonStatus = needShowBackToTop ? EnumBasePageScrollToTopStatus.hide : EnumBasePageScrollToTopStatus.dontShow;

      if (needLoadMoreScroll) {
        _addScrollListen();
      }

      if (isCallApiWhenInit) {
        _model.apiStatus.value = EnumBasePageCallApiStatus.waitInit;
        startApiProcess();
      } else {
        _model.apiStatus.value = EnumBasePageCallApiStatus.success;
        _updateLoadingStatus();
      }
    });
  }

  // MARK: - Override Method

  void resetHasMoreData() {
    _model.scrollButtonStatus = EnumBasePageScrollToTopStatus.hide;
    _model.page = 1;
    _model.hasMoreData = true;
    startApiProcess();
  }

  void configHasMoreData(bool hasMoreData) {
    _model.page += 1;
    _model.hasMoreData = hasMoreData;
  }

  Future<void> startApiProcess({
    bool isLoadMore = false,
  }) async {
    try {
      // 狀態處理
      if (isLoading) {
        return;
      } else if (isLoadMore) {
        _configApiStatus(
          EnumBasePageCallApiStatus.loadingMore,
        );
        await apiLoadMore();
      } else if (_model.apiStatus.value == EnumBasePageCallApiStatus.waitInit) {
        _configApiStatus(
          EnumBasePageCallApiStatus.firstCalling,
        );
        await apiProcessing();
      } else {
        _configApiStatus(
          EnumBasePageCallApiStatus.reloading,
        );
        await apiProcessing();
      }

      _configApiStatus(EnumBasePageCallApiStatus.success);
    } on BaseApiResponseModel<dynamic> catch (error) {
      final isFirstLoad = _model.apiStatus.value == EnumBasePageCallApiStatus.firstCalling;
      _configApiStatus(EnumBasePageCallApiStatus.fail);
      unawaited(
        apiProcessFail(
          error,
          isFirstLoad: isFirstLoad,
        ),
      );
    }
  }

  Future<void> apiProcessing() async {}

  Future<void> apiLoadMore() async {}

  Future<void> apiProcessDone() async {}

  Future<void> apiProcessFail(
    BaseApiResponseModel<dynamic> error, {
    bool isFirstLoad = false,
  }) async {
    if (isFirstLoad) {
      Get.back();
    }
  }

  // MARK: - Private Method

  void _addScrollListen() {
    scrollController?.removeListener(() {});
    scrollController = ScrollController();
    scrollController?.addListener(() {
      if (scrollController != null) {
        final sv = scrollController!;

        if (_model.scrollButtonStatus != EnumBasePageScrollToTopStatus.dontShow) {
          if (sv.offset > 200 && _model.scrollButtonStatus != EnumBasePageScrollToTopStatus.show) {
            _model.scrollButtonStatus = EnumBasePageScrollToTopStatus.show;
            _model.isShowBackToTop.value = true;
          } else if (sv.offset <= 200 && _model.scrollButtonStatus != EnumBasePageScrollToTopStatus.hide) {
            _model.scrollButtonStatus = EnumBasePageScrollToTopStatus.hide;
            _model.isShowBackToTop.value = false;
          }
        }

        if (sv.position.pixels >= sv.position.maxScrollExtent - 200 && _model.hasMoreData) {
          startApiProcess(isLoadMore: true);
        }
      }
    });
  }

  void _configApiStatus(EnumBasePageCallApiStatus status) {
    _model.apiStatus.value = status;
    _updateLoadingStatus();

    switch (status) {
      case EnumBasePageCallApiStatus.firstCalling:
      case EnumBasePageCallApiStatus.reloading:
        break;
      default:
        apiProcessDone();
    }
  }

  void _updateLoadingStatus() {
    _model.isLoading.value = _model.apiStatus.value == EnumBasePageCallApiStatus.firstCalling ||
        _model.apiStatus.value == EnumBasePageCallApiStatus.reloading ||
        _model.apiStatus.value == EnumBasePageCallApiStatus.loadingMore;
  }

  @override
  void onClose() {
    _model.isPageActive = false;
    scrollController?.removeListener(() {});
    scrollController?.dispose();
    super.onClose();
  }
}
