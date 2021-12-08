import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/video_item.dart';
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
              return Item(state.videos[index]);
            },
            itemCount: state.videos.length,
            scrollDirection: Axis.vertical,
          );
        }),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item(this._videoItem, {Key? key}) : super(key: key);
  final VideoItem _videoItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: VideoPlayer(
          VideoPlayerController.network(
              _videoItem.video!.playlistV2!.hd!.playUrl!),
        ),
      ),
    );
  }
}
