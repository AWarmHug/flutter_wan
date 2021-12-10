import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AnswerLogic());
    final state = Get
        .find<AnswerLogic>()
        .state;

    return Container(
      child: GetBuilder<AnswerLogic>(builder: (logic) {
        return PageView.builder(
          itemBuilder: (context, index) {
            return PageItem(feedItem: state.feedItems[index]);
          },
          scrollDirection: Axis.vertical,
          controller: PageController(
            viewportFraction: 0.8,
          ),
        );
      }),
    );
  }
}

class PageItem extends StatelessWidget {
  const PageItem({Key? key, required this.feedItem}) : super(key: key);

  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(feedItem.target!.question!.title!),
    );
  }
}
