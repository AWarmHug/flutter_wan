import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/banner.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'home_page_repository.dart';

class HomePageController extends GetxController {
  HomePageRepository _repository = HomePageRepository();
  int _pageNum = 0;

  Rx<Resource<List<BannerItem>>> banners = Rx(Resource.loading());

  List<Article> _art = [];

  Rx<Resource<List<Article>>> articles = Rx(Resource.loading());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadBanner();
    _loadArticleList(0);
  }

  void loadBanner() async {
    banners.value = Resource.loading();
    ResponseWan<List<BannerItem>> responseWan = await _repository.loadBanner();
    if (responseWan.isSuccess && responseWan.data != null) {
      banners.value = Resource.success(responseWan.data);
    } else {
      banners.value = Resource.error("失败");
    }
  }

  void loadArticleListNext() async {
    _pageNum++;
    _loadArticleList(_pageNum);
  }

  void _loadArticleList(int pageNum) async {
    if (isPage0()) {
      articles.value = Resource.loading();
    }else{
      articles.value = Resource.loadingMore(_art);
    }
    ResponseWan<ListData<Article>> responseWan =
        await _repository.loadArticleList(pageNum);
    if (responseWan.isSuccess && responseWan.data != null) {
      if (pageNum == 0) {
        _art.clear();
        _art.addAll(responseWan.data!.datas);
      } else {
        _art.addAll(responseWan.data!.datas);
      }
      articles.value = Resource.success(_art);
    } else {
      articles.value = Resource.error("失败");
    }
  }

  bool isPage0() {
    return _pageNum == 0;
  }
}
