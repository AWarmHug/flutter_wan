import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/question.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';

class QuestionTitleWidget extends StatelessWidget {
  const QuestionTitleWidget({Key? key, required this.question}) : super(key: key);
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question.title!,
      style: AppTextStyles.black_16.bold,
    );
  }
}


class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, this.question}) : super(key: key);
  final Question? question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 12),
      child: question != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question!.title!,
            style: AppTextStyles.black_18_bold,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            question!.excerpt??"",
            style: AppTextStyles.black_14,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "知乎 · ${question!.answerCount!}个回答 · ${question!
                .followerCount!}个关注",
            style: AppTextStyles.black_12.color2(Colors.black45),
          ),
        ],
      )
          : Text("数据错误"),
    );
  }
}
