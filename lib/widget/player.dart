import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/play_list.dart';
import 'package:flutter_wan/eventbus.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final PlayItem playItem;

  const AppVideoPlayer(this.playItem);

  @override
  State<StatefulWidget> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _controller;

  //Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    debugPrint("播放视频："+widget.playItem.playUrl!);
    _controller = VideoPlayerController.network(widget.playItem.playUrl!)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      }).catchError((error){
        debugPrint("发生错误：${error.toString()}");
      });
    bus.on("video", (arg) {
      if(arg){
        _controller.play();
      }else{
        _controller.pause();
      }

    });
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      alignment: Alignment.center,
      color: Colors.black,
      //height: double.infinity,
      child: _controller.value.isInitialized
          ? GestureDetector(
              onTap: () {
                print(_controller.value.aspectRatio);
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio:
                    widget.playItem.width! * 1.0 / widget.playItem.height!,
                //_controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : loadingVideo(),
    );
  }

  Widget loadingVideo() => Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
