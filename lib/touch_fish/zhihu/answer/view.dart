import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AnswerLogic());
    final state = Get.find<AnswerLogic>().state;

    return Container(
      color: Colors.white,
      child: GetBuilder<AnswerLogic>(
        init: logic,
        builder: (logic) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                child: PageItem(feedItem: state.feedItems[index]),
              );
            },
            itemCount: state.feedItems.length,
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: AppColors.bg_default,
                height: 8,
              );
            },
          );
        },
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  const PageItem({Key? key, required this.feedItem}) : super(key: key);

  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    debugPrint("_______${feedItem.target!.question}");
    return InkWell(
      onTap: () {
        Get.toNamed("/touch_fish/zhihu/answer_detail",arguments: feedItem);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            QuestionWidget(
              question: feedItem.target!.question!,
            ),
            SizedBox(
              height: 8,
            ),
            ExceptWidget(
              feedItem: feedItem,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${feedItem.target!.voteupCount!} 赞同",
                  style: AppTextStyles.black_14.size(12).color2(Colors.black54),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "${feedItem.target!.commentCount!} 评论",
                  style: AppTextStyles.black_14.size(12).color2(Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, required this.question}) : super(key: key);
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question.title!,
      style: AppTextStyles.black_16.bold,
    );
  }
}

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppNetWorkImage(
            imageUrl: author.avatarUrl!,
            width: 16,
            height: 16,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          author.name!,
          style: AppTextStyles.black_12.bold,
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Text(
            author.headline!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.black_12.color2(Colors.black54),
          ),
        ),
      ],
    );
  }
}

class ExceptWidget extends StatelessWidget {
  const ExceptWidget({Key? key, required this.feedItem}) : super(key: key);
  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              AuthorWidget(
                author: feedItem.target!.author!,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                feedItem.target!.excerpt!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.black_14.color2(Colors.black87),
              ),
            ],
          ),
        ),
        image(),
      ],
    );
  }

  image() {
    return (feedItem.target!.thumbnail != null &&
            feedItem.target!.thumbnail!.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: AppNetWorkImage(
              imageUrl: feedItem.target!.thumbnail!,
              width: 92,
              height: 64,
              fit: BoxFit.fill,
            ),
          )
        : SizedBox();
  }
}
