import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/extensions.dart';
import 'package:get/get.dart';

import '../../../error.dart';
import '../../../http.dart';
import 'state.dart';

class AnswerLogic extends GetxController {
  final AnswerState state = AnswerState();

  int offset=0;
  int limit=15;

  @override
  void onInit() {
    super.onInit();
    refreshFeedList();

  }


  void refreshFeedList(){
    offset=0;
    _loadFeedList().then((value) {
      debugPrint("--------成功");
    }).catchAppError((appError) {
      debugPrint("--------错误");
    });
  }

  void loadFeedList(){
    _loadFeedList().then((value) {
    }).catchAppError((appError) {
    });
  }

  Future<void> _loadFeedList() async {
    var response = await Http.get<List<FeedItem>>(
        "v3/explore/guest/feeds?limit=${limit}&offset=${offset}");
    if (response.isSuccess) {
      if (response.data != null && response.data!.isNotEmpty) {
        offset+=limit;
        state.feedItems = response.data!;
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(response.error!);
    }
  }




}
