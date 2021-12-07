import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/banner.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/home/state.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'repository.dart';

class HomePageController extends GetxController {
  HomePageState state = HomePageState();
  HomePageRepository _repository = HomePageRepository();

  int _pageNum = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshArticleList();
  }

  Future<void> refreshArticleList() {
    return _loadArticleList(0);
  }

  void loadArticleListNext() {
    _loadArticleList(_pageNum).then((value) {});
  }

  Future<void> _loadArticleList(int pageNum) async {
    changeStatus(Status.LOADING);
    update();
    if (pageNum == 0) {
      ResponseWan<List<BannerItem>> banners = await _repository.loadBanner();
      if (banners.isSuccess && banners.data != null) {
        state.banners = Resource.success(banners.data);
      } else {
        state.banners = Resource.error(banners.errorMsg);
      }
    }
    ResponseWan<ListData<Article>> responseWan =
        await _repository.loadArticleList(pageNum);
    if (responseWan.isSuccess && responseWan.data != null) {
      if (pageNum == 0) {
        state.articles.clear();
        state.articles.addAll(responseWan.data!.datas);
      } else {
        state.articles.addAll(responseWan.data!.datas);
      }
      changeStatus(Status.SUCCESS);
      _pageNum++;
    } else {
      changeStatus(Status.ERROR);
    }
    update();
  }

  bool isPage0() {
    return _pageNum == 0;
  }

  void changeStatus(Status status) {
    if (isPage0()) {
      state.refresh = status;
    } else {
      debugPrint("----------status = ${status.name}");
      state.loadingMore.value = status;
    }
  }
}
