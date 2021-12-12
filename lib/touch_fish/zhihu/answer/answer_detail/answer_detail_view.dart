import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

import 'answer_detail_logic.dart';

class AnswerDetailPage extends StatelessWidget {
  final logic = Get.put(AnswerDetailLogic());
  final state = Get
      .find<AnswerDetailLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AnswerDetailLogic>(builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _QuestionWidget(
                question: state.feedItem.target!.question,
              ),
              Container(
                color: Colors.black12,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 0.5,
              ),
              _AuthorWidget(
                author: state.feedItem.target!.author!,
              ),
              _ContentWidget(
                feedItem: state.feedItem,
              ),
              _CommentsWidget(
                count: state.feedItem.target!.commentCount!,
                comments: state.comments,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _QuestionWidget extends StatelessWidget {
  const _QuestionWidget({Key? key, this.question}) : super(key: key);
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

class _AuthorWidget extends StatelessWidget {
  const _AuthorWidget({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 12),
      child: Row(
        children: [
          ClipOval(
            child: AppNetWorkImage(
              imageUrl: author.avatarUrl!,
              width: 36,
              height: 36,
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
                  author.name!,
                  style: AppTextStyles.black_14.bold,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  author.headline!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppTextStyles.black_12.color2(Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key, required this.feedItem}) : super(key: key);
  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: "<body>${feedItem.target!.content}</body>",
            style: {
              "body": Style(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                fontSize: FontSize(15),
                letterSpacing: 0.8,
                lineHeight: LineHeight(1.4),
                fontWeight: FontWeight.normal,
              ),
            },
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            feedItem.updatedTime != feedItem.createdTime
                ? "编辑于 ${feedItem.updatedTime!.date().format()} 创作于 ${feedItem
                .createdTime!.date().format()}"
                : "创作于 ${feedItem.createdTime!.date().format()}",
            style: AppTextStyles.black_12.black38,
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class _CommentsWidget extends StatelessWidget {
  const _CommentsWidget({Key? key, required this.count, required this.comments})
      : super(key: key);
  final int count;
  final List<AnswerComment> comments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[]
          ..add(Text(
            "评论${count}",
            style: AppTextStyles.black_16.bold,
          ))..add(SizedBox(
            height: 16,
          ))
          ..addAll(comments.take(3).map((e) {
            return _CommentItemWidget(
              comment: e,
            ) as Widget;
          }).toList())
          ..add(
            Row(
              children: [
                Text(
                  "查看全部评论",
                  style: AppTextStyles.black_12.black38,
                ),
                Icon(Icons.ten_k),
              ],
            ),
          ),
      ),
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
            child: AppNetWorkImage(
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
