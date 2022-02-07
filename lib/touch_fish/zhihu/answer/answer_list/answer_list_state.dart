import 'package:flutter_wan/data/zhihu/answer_list_item.dart';
import 'package:flutter_wan/data/zhihu/question.dart';
import 'package:get/get.dart';

class AnswerListState {

  AnswerListState() {
    ///Initialize variables
  }

  Question? question;

  List<AnswerListItem> answers = [];
}
