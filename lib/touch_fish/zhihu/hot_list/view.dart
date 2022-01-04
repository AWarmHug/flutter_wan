import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/hot_list_feed.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_images.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'logic.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({required this.type});

  final Tuple2<String, String> type;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(QuestionLogic(widget.type), tag: widget.type.item2);
    final state = Get.find<QuestionLogic>(tag: widget.type.item2).state;

    return NotificationListener(
      child: Container(
        child: GetBuilder<QuestionLogic>(
            init: logic,
            tag: widget.type.item2,
            builder: (logic) {
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
      ),
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          print("小部件已开始滚动 ${notification.toString()}");
        }else if(notification is ScrollUpdateNotification){
          print("小部件正在滚动 ${notification.scrollDelta}");
        }
        return true;
      },
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
        Get.toNamed("/touch_fish/zhihu/answer_list",
            arguments: hotListFeed.target!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    IconFontIcons.iconHot,
                    color: index == 0
                        ? Colors.red
                        : index == 1
                            ? Colors.amber
                            : index == 2
                                ? Colors.amberAccent
                                : Colors.transparent,
                  ),
                  Text(
                    "${index + 1}",
                    style: index < 3
                        ? AppTextStyles.white_12.bold
                        : AppTextStyles.black_12.bold.color2(Colors.black45),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotListFeed.target!.title!,
                    style: AppTextStyles.black_16.bold,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotListFeed.target!.title ?? "",
                          style: AppTextStyles.black_14,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      image(),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    hotListFeed.detail_text!,
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  image() {
    return (hotListFeed.children != null && hotListFeed.children!.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: AppNetworkImage(
              imageUrl: hotListFeed.children![0].thumbnail!,
              width: 92,
              height: 64,
              fit: BoxFit.fill,
            ),
          )
        : SizedBox();
  }
}
