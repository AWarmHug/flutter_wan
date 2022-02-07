import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/answer_comments.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/paging.dart';
import 'package:flutter_wan/data/zhihu/target.dart';
import 'package:get/get.dart';

import '../../../../error.dart';
import '../../../../http.dart';
import 'answer_detail_state.dart';

class AnswerDetailLogic extends GetxController {
  AnswerDetailLogic();

  final AnswerDetailState state = AnswerDetailState();

  late Target _target;

  set target(Target value) {
    _target = value;
    paging = null;
    state.comments.clear();
  }

  Paging? paging;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    debugPrint("---------onInit");
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.pixels > 200) {
          if (state.title == null) {
            state.title = _target.question!.title;
            update(["title"]);
          }
        } else {
          if (state.title != null) {
            state.title = null;
            update(["title"]);
          }
        }
      });
  }

  Future<void> loadAnswerComments() async {
    String path;

    if (paging == null) {
      path =
          "v4/answers/${_target.id!}/comments?include=data%5B*%5D.author&order=normal&limit=10&offset=0&status=open";
    } else {
      path = paging!.next!;
    }

    var response = await Http.get2<AnswerComments, List<AnswerComment>>(path);
    if (response.isSuccess) {
      if (response.data != null && response.data!.isNotEmpty) {
        //获取评论
        paging = response.paging;
        state.comments.addAll(response.data!);
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(response.error!);
    }
  }
}
