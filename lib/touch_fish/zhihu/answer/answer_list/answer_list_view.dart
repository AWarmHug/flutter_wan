import 'package:flutter/material.dart';
import 'package:flutter_wan/component/zhihu/answer.dart';
import 'package:flutter_wan/component/zhihu/question.dart';
import 'package:get/get.dart';

import 'answer_list_logic.dart';

class AnswerListPage extends StatelessWidget {
  final logic = Get.put(AnswerListLogic());
  final state = Get.find<AnswerListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AnswerListLogic>(builder: (logic) {
        return ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return QuestionWidget(
                  question: state.question,
                );
              } else {
                return InkWell(
                  onTap: () {
                    state.answers[index - 1].question=state.question!;
                    Get.toNamed("/touch_fish/zhihu/answer_detail",
                        arguments: state.answers[index - 1]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: AnswerWidget(target: state.answers[index - 1]),
                  ),
                );
              }
            },
            separatorBuilder: (context, index) {
              return Container(
                height: index == 0 ? 1 : 8,
                color: Colors.grey.shade200,
              );
            },
            itemCount: state.answers.length + 1);
      }),
    );
  }
}
