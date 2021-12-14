import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/answer_comments.dart';
import 'package:flutter_wan/data/zhihu/paging.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

import '../../../../error.dart';
import '../../../../http.dart';
import 'comments_state.dart';

class CommentsLogic extends GetxController {
  final CommentsState state = CommentsState();

  Paging? paging;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  void refreshVideoComment(String id){
    _loadVideoComment(id).then((value) {

    }).catchAppError((appError) {

    });
  }



  Future<void> _loadVideoComment(String id) async {
    state.comments.clear();

    String path =
        "v4/zvideos/${id}/root_comments?order=normal&limit=20&offset=0&status=open";
    if (paging != null && paging!.isEnd == false && paging!.next != null) {
      path = paging!.next!;
    } else {}

    var response = await Http.get2<AnswerComments, List<AnswerComment>>(path);
    if (response.isSuccess) {
      if (response.data != null && response.data!.isNotEmpty) {
        //获取评论
        paging = response.paging;
        state.comments.clear();
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
