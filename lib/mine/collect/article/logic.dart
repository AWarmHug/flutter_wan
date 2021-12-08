import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/collect.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

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
    update();
    var responseWan =
        await Http.get<ListData<Collect>>("lg/collect/list/${_pageNum}/json");
    state.refresh = false;
    if (responseWan.isSuccess) {
      if (responseWan.data != null && responseWan.data!.datas.isNotEmpty) {
        if (_pageNum == 0) {
          state.list.clear();
        }
        if (responseWan.data!.datas.isNotEmpty) {
          _pageNum += 1;
        }
        state.list.addAll(responseWan.data!.datas);
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(AppError.from(responseWan));
    }
  }

  void refreshList() {
    _pageNum = 0;
    bool a=true;
    _loadCollectList().then((value) {
      refreshController.refreshSuccess();
    }).catchAppError((appError) {
      refreshController.refreshError(appError.code);
    });
  }

  void loadNextPage() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => _loadCollectList())
        .then((value) {
      refreshController.loadSuccess();
    }).catchAppError((appError) {
      refreshController.loadError(appError.code);
    });
  }
}
