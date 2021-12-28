import 'package:flutter/material.dart';
import 'package:flutter_wan/component/zhihu/answer.dart';
import 'package:flutter_wan/component/zhihu/question.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/question.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AnswerPage extends StatefulWidget {
  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final logic = Get.put(AnswerLogic());
    final state = Get.find<AnswerLogic>().state;

    return NotificationListener(
      child: Container(
        color: Colors.white,
        child: GetBuilder<AnswerLogic>(
          init: logic,
          builder: (logic) {
            return ListView.separated(
              physics: AlwaysScrollableScrollPhysics (),
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
      ),
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          print("------小部件已开始滚动 ${notification.toString()}");
        } else if (notification is ScrollUpdateNotification) {
          print("------小部件正在滚动 ${notification.scrollDelta}");
        }

        return true;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PageItem extends StatelessWidget {
  const PageItem({Key? key, required this.feedItem}) : super(key: key);

  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    debugPrint("_______${feedItem.target!.question}");
    return InkWell(
      onTap: () {
        Get.toNamed("/touch_fish/zhihu/answer_detail", arguments: feedItem.target);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            QuestionTitleWidget(
              question: feedItem.target!.question!,
            ),
            SizedBox(
              height: 8,
            ),
            AnswerWidget(
              target: feedItem.target!,
            ),
          ],
        ),
      ),
    );
  }
}
