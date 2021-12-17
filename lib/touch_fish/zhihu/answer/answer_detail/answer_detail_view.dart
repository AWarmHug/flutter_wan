import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan/component/zhihu/question.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/question.dart';
import 'package:flutter_wan/data/zhihu/target.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/touch_fish/zhihu/answer/answer_comments/answer_comments_view.dart';
import 'package:flutter_wan/touch_fish/zhihu/video/comments/comments_view.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

import 'answer_detail_logic.dart';

class AnswerDetailPage extends StatelessWidget {
  final logic = Get.put(AnswerDetailLogic());
  final state = Get.find<AnswerDetailLogic>().state;

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
              QuestionWidget(
                question: state.feedItem.target!.question,
              ),
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width,
                height: 0.5,
              ),
              _AuthorWidget(
                author: state.feedItem.target!.author!,
              ),
              _ContentWidget(
                feedItem: state.feedItem,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
                child: _CommentsWidget(
                  target: state.feedItem.target!,
                  comments: state.comments,
                ),
              ),
            ],
          );
        }),
      ),
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
            child: AppNetworkImage(
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
                ? "编辑于 ${feedItem.updatedTime!.date().format()} 创作于 ${feedItem.createdTime!.date().format()}"
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
  const _CommentsWidget(
      {Key? key, required this.target, required this.comments})
      : super(key: key);
  final Target target;
  final List<AnswerComment> comments;

  @override
  Widget build(BuildContext context) {
    return comments.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[]
              ..add(Text(
                "评论 ${target.commentCount}",
                style: AppTextStyles.black_16.bold,
              ))
              ..add(SizedBox(
                height: 16,
              ))
              ..addAll(comments.take(3).map((e) {
                return _CommentItemWidget(
                  comment: e,
                ) as Widget;
              }).toList())
              ..add(
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "查看全部评论",
                        style: AppTextStyles.black_12.black38,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))) ,
                      builder: (context) {
                        return Container(
                          height:MediaQuery.of(context).size.height * 12.0 / 16.0 ,
                          padding: EdgeInsets.only(
                              left: 12, top: 16, right: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: AnswerCommentsPage(target.id!),
                        );
                      },
                    );
                  },
                ),
              ),
          )
        : LinearProgressIndicator();
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
                Text(
                  comment.createdTime!.date().format(),
                  style: AppTextStyles.black_12.black38,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
