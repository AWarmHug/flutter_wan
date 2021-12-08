import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/answer.dart';
import 'package:flutter_wan/data/zhihu/zvideo.dart';
import 'package:flutter_wan/widget/player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put<HomeLogic>(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("知乎"),
      ),
      body: Container(
        child: GetBuilder<HomeLogic>(builder: (logic) {
          return PageView.builder(
            itemBuilder: (context, index) {
              if (state.videos[index] is Answer) {
                return AnswerItem(state.videos[index] as Answer);
              } else if (state.videos[index] is ZVideo) {
                return ZVideoItem(state.videos[index] as ZVideo);
              } else {
                return Text(state.videos[index].type!);
              }
            },
            itemCount: state.videos.length,
            scrollDirection: Axis.vertical,
          );
        }),
      ),
    );
  }
}

class ZVideoItem extends StatelessWidget {
  const ZVideoItem(this.zvideo, {Key? key}) : super(key: key);
  final ZVideo zvideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AppVideoPlayer(
          zvideo.video!.getPlayItem()!,
        ),
      ),
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem(this.answer, {Key? key}) : super(key: key);
  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AppVideoPlayer(
          answer.video!.getPlayItem()!,
        ),
      ),
    );
  }
}
