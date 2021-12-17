import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/extensions.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';

import 'answer_comments_logic.dart';

class AnswerCommentsPage extends StatefulWidget {
  AnswerCommentsPage(this.id);

  final int id;

  @override
  State<AnswerCommentsPage> createState() => _AnswerCommentsPageState();
}

class _AnswerCommentsPageState extends State<AnswerCommentsPage> {
  final logic = Get.put(AnswerCommentsLogic());

  final state = Get.find<AnswerCommentsLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.loadAnswerComments(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "评论",
          style: AppTextStyles.black_18_bold,
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: GetBuilder<AnswerCommentsLogic>(builder: (logic) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return _CommentItemWidget(
                  comment: state.comments[index],
                );
              },
              itemCount: state.comments.length,
            );
          }),
        ),
      ],
    );
  }
}

class _CommentItemWidget extends StatelessWidget {
  const _CommentItemWidget({Key? key, required this.comment}) : super(key: key);
  final AnswerComment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: AppNetworkImage(
              imageUrl: comment.author!.member!.avatarUrl!,
              width: 32,
              height: 32,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.author!.member!.name!,
                  style: AppTextStyles.black_14.bold,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  comment.content!,
                  style: AppTextStyles.black_14,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      comment.createdTime!.date().format(),
                      style: AppTextStyles.black_12.black38,
                    ),
                    Icon(Icons.ten_k),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
