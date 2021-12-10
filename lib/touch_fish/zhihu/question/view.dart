import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/hot_list_feed.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';

import 'logic.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(QuestionLogic());
    final state = Get.find<QuestionLogic>().state;

    return Container(
      child: GetBuilder<QuestionLogic>(builder: (logic) {
        return SmartRefresher(
          onRefresh: logic.refreshHotListWeb,
          onLoad: logic.loadHotListWeb,
          refreshController: logic.refreshController,
          itemBuilder: (context, index) {
            return QuestionWidget(
              hotListFeed: state.hotListFeed[index],
              index: index,
            );
          },
          itemCount: state.hotListFeed.length,
          footer: (status) {
            return StatusMoreWidget(status: status);
          },
        );
      }),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key, required this.index, required this.hotListFeed})
      : super(key: key);

  final int index;
  final HotListFeed hotListFeed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo 跳转
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: index < 3 ? Colors.red : Colors.transparent,
              ),
              width: 24,
              height: 24,
              child: Text("${index}"),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotListFeed.target!.titleArea!.text!,
                    style: AppTextStyles.black_16.bold,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    hotListFeed.target!.metricsArea!.text!,
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            image(),
          ],
        ),
      ),
    );
  }

  image() {
    return (hotListFeed.target!.imageArea!.url != null &&
            hotListFeed.target!.imageArea!.url!.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: AppNetWorkImage(
              imageUrl: hotListFeed.target!.imageArea!.url!,
              width: 92,
              height: 68,
              fit: BoxFit.fill,
            ),
          )
        : SizedBox();
  }
}
