import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/widget/smart_refresh.dart';
import 'package:get/get.dart';

import '../repository.dart';
import 'state.dart';

class PageItemLogic extends GetxController {
  PageItemLogic(this._tree);

  final PageItemState state = PageItemState();
  final _repository = ProjectRepository();
  final RefreshController refreshController = RefreshController();
  Tree _tree;
  int pageNum = 0;

  @override
  void onInit() {
    super.onInit();
    refreshProjectList();
  }

  void refreshProjectList() {
    pageNum = 0;
    _loadProjectList().then((value) {
      refreshController.refreshSuccess();
    }).catchError((error) {
      refreshController.refreshError(error.code);
    });
  }

  void loadMoreProjectList() {
    _loadProjectList().then((value) {
      refreshController.loadSuccess();
    }).catchError((error) {
      refreshController.loadError(error.code);
    });
  }

  Future<void> _loadProjectList() async {
    ResponseWan<ListData<Article>> responseWan =
        await _repository.loadProjectList(pageNum, _tree.id);
    if (responseWan.isSuccess && responseWan.data != null) {
      if (responseWan.data!.datas.isNotEmpty) {
        if (pageNum == 0) {
          state.articles.clear();
        }
        state.articles.addAll(responseWan.data!.datas);
        pageNum++;
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(AppError.from(responseWan));
    }
  }
}
