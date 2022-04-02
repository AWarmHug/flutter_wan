import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';

import '../wx_article_repository.dart';
import 'state.dart';

class WxArticleDetailPageController extends GetxController {
  WxArticleDetailPageController(this.tree);

  WXArticleRepository _repository = WXArticleRepository();
  RefreshController refreshController = RefreshController();

  WxArticleDetailPageState state = WxArticleDetailPageState();

  Tree tree;

  String? _keyword;

  int _pageNum = 0;

  @override
  void onInit() {
    super.onInit();
    refreshList();
  }

  void setShowSearchView(bool showSearchView) {
    state.showSearchView = showSearchView;
  }

  void refreshList() {
    _pageNum = 0;
    loadWXArticleList().then((value) {
      refreshController.refreshSuccess();
    }).catchError((onError) {
      refreshController.refreshError();
    });
  }

  void loadMore() {
    loadWXArticleList().then((value) {
      refreshController.loadSuccess();
    }).catchError((onError) {
      refreshController.loadError();
    });
  }

  Future<void> loadWXArticleList() async {
    ResponseWan<ListData<Article>> responseWan = await _repository
        .loadWXArticleList(tree.id!, _pageNum, keyword: _keyword);
    if (responseWan.isSuccess) {
      if (_pageNum == 0) {
        state.articles.clear();
        state.articles.addAll(responseWan.data!.datas);
      } else {
        state.articles.addAll(responseWan.data!.datas);
      }
      _pageNum += 1;
    } else {}
    update();
  }

  void setSearchKeyword(String keyword) {
    _keyword = keyword;
  }

  static WxArticleDetailPageController get to => Get.find();
}
