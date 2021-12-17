import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/target.dart';
import 'package:get/get.dart';

class AnswerDetailState {
  AnswerDetailState() {
    ///Initialize variables
  }
  Target target = Get.arguments;

  List<AnswerComment> comments=[];

  String? title;



}
