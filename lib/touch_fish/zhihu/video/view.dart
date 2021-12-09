import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/answer.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/zvideo.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/player.dart';
import 'package:get/get.dart';

import 'logic.dart';

class VideoPage extends StatelessWidget {
  final logic = Get.put<VideoLogic>(VideoLogic());
  final state = Get.find<VideoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<VideoLogic>(builder: (logic) {
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
    );
  }
}

class ZVideoItem extends StatelessWidget {
  const ZVideoItem(this.zvideo, {Key? key}) : super(key: key);
  final ZVideo zvideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: AppVideoPlayer(
                    zvideo.video!.getPlayItem()!,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(""),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zvideo.title!,
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AuthorWidget(
                          author: zvideo.author!,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(zvideo.likedCount!.toString()),
                                Icon(Icons.ac_unit)
                              ],
                            ),
                            Column(
                              children: [
                                Text(zvideo.commentCount!.toString()),
                                Icon(Icons.ac_unit)
                              ],
                            ),
                            Column(
                              children: [
                                Text(zvideo.shareCount!.toString()),
                                Icon(Icons.ac_unit)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
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

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: author.avatarUrl!,
              width: 42,
              height: 42,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.name!,
                  style: AppTextStyles.white_16_bold,
                ),
                Text(
                  author.headline!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.white_14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
