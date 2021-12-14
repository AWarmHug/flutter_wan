import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/answer.dart';
import 'package:flutter_wan/data/zhihu/answer_comment.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/zvideo.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/player.dart';
import 'package:get/get.dart';

import 'comments/comments_view.dart';
import 'logic.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put<VideoLogic>(VideoLogic());
    final state = Get
        .find<VideoLogic>()
        .state;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Container(
          color: Colors.black,
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
        ),
      ),
    );
  }
}

class ZVideoItem extends StatelessWidget {
  final logic = Get.put<VideoLogic>(VideoLogic());

  final state = Get
      .find<VideoLogic>()
      .state;

  ZVideoItem(this.zvideo, {Key? key}) : super(key: key);
  final ZVideo zvideo;


  TopicsWid() {
    return zvideo.topics != null
        ? TopicsWidget(
      topics: zvideo.topics!,
    )
        : SizedBox();
  }

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
                    maxLines: 2,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TopicsWid(),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
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
                                Icon(Icons.ac_unit),
                                Text(zvideo.shareCount!.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.ac_unit),
                                Text(zvideo.likedCount!.toString()),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                //显示
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CommentsPage(zvideo.id!);
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.ac_unit),
                                  Text(zvideo.commentCount!.toString()),
                                ],
                              ),
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
              width: 48,
              height: 48,
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
                  style: AppTextStyles.white_14.bold,
                ),
                Text(
                  author.headline!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.white_12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopicsWidget extends StatelessWidget {
  const TopicsWidget({Key? key, required this.topics}) : super(key: key);
  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: topics.map((e) => TopicWidget(e)).toList(),
    );
  }
}

class TopicWidget extends StatelessWidget {
  const TopicWidget(this.topic, {Key? key}) : super(key: key);
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "#${topic.name!} ",
        style: AppTextStyles.white_14.bold,
      ),
    );
  }
}
