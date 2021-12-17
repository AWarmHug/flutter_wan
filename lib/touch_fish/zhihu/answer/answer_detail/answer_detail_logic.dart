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
  final AnswerDetailState state = AnswerDetailState();

  Target target = Get.arguments;
  Paging? paging;

  Future<void> loadAnswerComments() async {
    String path;

    if (paging == null) {
      path =
          "v4/answers/${target.id!}/comments?include=data%5B*%5D.author&order=normal&limit=10&offset=0&status=open";
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

  @override
  void onInit() {
    super.onInit();
    loadAnswerComments();
  }
}
