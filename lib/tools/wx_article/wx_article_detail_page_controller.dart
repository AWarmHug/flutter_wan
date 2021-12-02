import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/tools/wx_article/wx_article_repository.dart';
import 'package:get/get.dart';

class WxArticleDetailPageController extends GetxController {
  WXArticleRepository _repository = WXArticleRepository();

  ScrollController scrollController = ScrollController();

  Rx<Resource<ListData<Article>?>> listData = Rx(Resource.loading());

  Rx<bool> showSearchView = Rx(false);

  Tree tree = Get.arguments;

  int _pageNum = 0;

  @override
  void onInit() {
    super.onInit();
    loadWXArticleList();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //已经滑到底了
        _pageNum += 1;
        loadWXArticleList();
      }
    });
  }

  void loadWXArticleList({int? pageNum, String? keyword}) async {
    if (pageNum != null) {
      _pageNum = pageNum;
    }
    if (_pageNum == 0) {
      listData.value = Resource.loading();
    } else {
      listData.value = Resource.loadingMore(listData.value.data);
    }
    ResponseWan<ListData<Article>> responseWan = await _repository
        .loadWXArticleList(tree.id!, _pageNum, keyword: keyword);
    if (responseWan.isSuccess) {
      if (_pageNum == 0) {
        listData.value = Resource.success(responseWan.data);
      } else {
        var data = listData.value.data!;
        data.datas.addAll(responseWan.data!.datas);
        listData.value = Resource.success(data);
      }
    } else {
      listData.value = Resource.error("");
    }
  }

  static WxArticleDetailPageController get to => Get.find();
}
