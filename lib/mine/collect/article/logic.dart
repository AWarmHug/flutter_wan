import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/collect.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/widget/smart_refresh.dart';
import 'package:get/get.dart';

import 'state.dart';

class ArticleLogic extends GetxController {
  final ArticleState state = ArticleState();

  RefreshController refreshController = RefreshController();
  int _pageNum = 0;

  @override
  void onInit() {
    super.onInit();
    refreshList();
  }

  Future<void> _loadCollectList() async {
    state.refresh = true;
    var responseWan =
        await Http.get<ListData<Collect>>("lg/collect/list/${_pageNum}/json");
    state.refresh = false;
    if (responseWan.isSuccess) {
      if (_pageNum == 0) {
        state.list.clear();
      }
      state.list.addAll(responseWan.data!.datas);
    } else {}
    update();
  }

  void refreshList() {
    _pageNum = 0;
    _loadCollectList().then((value) {
      refreshController.refreshSuccess();
    }).catchError((error) {
      refreshController.refreshError();
    });
  }

  void loadNextPage() {
    _pageNum += 1;
    _loadCollectList().then((value) {
      refreshController.loadSuccess();
    }).catchError((error) {
      refreshController.loadError();
    });
  }
}
