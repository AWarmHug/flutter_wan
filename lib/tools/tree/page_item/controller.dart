import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/tools/tree/page_item/state.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';

import '../repository.dart';

class PageItemController extends GetxController {
  final state = PageItemState();

  final refreshController = RefreshController();
  final _treeResponse = TreeRepository();

  final Tree tree;

  int pageNum = 0;

  PageItemController(this.tree);


  @override
  void onInit() {
    super.onInit();
    refreshList(tree);
  }

  void refreshList(Tree tree) {
    pageNum = 0;
    _loadTreeList(tree).then((value) {
      refreshController.refreshSuccess();
    }).catchError((error) {
      if(error is AppError) {
        if(error.code==AppError.ERROR_NO_DATA) {
          refreshController.refreshNoData();
        }else{
          refreshController.refreshError();
        }
      }
    });
  }

  void loadMoreList(Tree tree) {
    _loadTreeList(tree).then((value) {
      refreshController.loadSuccess();
    }).catchError((error) {
      if(error is AppError) {
       if(error.code==AppError.ERROR_NO_DATA) {
         refreshController.loadNoData();
       }else{
         refreshController.loadError();
       }
      }
    });
  }

  Future<void> _loadTreeList(Tree tree) async {
    ResponseWan<ListData<Article>> responseWan =
        await _treeResponse.loadTreeList(pageNum, tree.id!);
    if (responseWan.isSuccess ) {
      if (responseWan.data != null &&
          responseWan.data!.datas.isNotEmpty) {
        if (pageNum == 0) {
          state.articles.clear();
        }
        state.articles.addAll(responseWan.data!.datas);
        pageNum++;
        update();
      }else{
        //无数据
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(AppError.from(responseWan));
    }
  }
}
