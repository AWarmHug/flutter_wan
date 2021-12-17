import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan/component/zhihu/question.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/target.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/touch_fish/zhihu/answer/answer_comments/answer_comments_view.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'answer_detail_logic.dart';

class AnswerDetailPage extends StatefulWidget {
  @override
  State<AnswerDetailPage> createState() => _AnswerDetailPageState();
}

class _AnswerDetailPageState extends State<AnswerDetailPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(AnswerDetailLogic());

  final state = Get.find<AnswerDetailLogic>().state;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<AnswerDetailLogic>(
          id: "title",
          builder: (logic) {
            if (state.title != null) {
              controller.reset();
              controller.forward();
            }else{
              controller.reverse();
            }
            return FadeTransition(
              opacity: controller,
              child: Container(
                child: Text(state.target.question!.title!),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: logic.scrollController,
        child: GetBuilder<AnswerDetailLogic>(builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionWidget(
                question: state.target.question,
              ),
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width,
                height: 0.5,
              ),
              _AuthorWidget(
                author: state.target.author!,
              ),
              _ContentWidget(
                target: state.target,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
                child: _CommentsWidget(
                  target: state.target,
                  comments: state.comments,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

class _ContentWidget extends StatefulWidget {
  const _ContentWidget({Key? key, required this.target}) : super(key: key);
  final Target target;

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: "<body>${widget.target.content}</body>",
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
            widget.target.updatedTime != widget.target.createdTime
                ? "编辑于 ${widget.target.updatedTime!.date().format()} 创作于 ${widget.target.createdTime!.date().format()}"
                : "创作于 ${widget.target.createdTime!.date().format()}",
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
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12))),
                      builder: (context) {
                        return Container(
                          height:
                              MediaQuery.of(context).size.height * 12.0 / 16.0,
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
