import 'package:flutter_wan/data/zhihu/paging.dart';
import 'package:flutter_wan/data/zhihu/video_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

import '../../../http.dart';
import 'state.dart';

class VideoLogic extends GetxController {
  final VideoState state = VideoState();

  Paging? paging;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadVideo();
  }

  void loadVideo() async {
    String path =
        "v4/zvideo-tabs/tabs/choice/feeds/recommend?include=creation_relationship&limit=20&offset=0&trans=";
    if (paging != null && paging!.isEnd == false && paging!.next != null) {
      path = paging!.next!;
    } else {}

    Http.get<List<VideoItem>>(path).then((response) {
      if (response.isSuccess) {
        state.videos.addAll(response.data!);
        paging = response.paging;
      } else {}
      update();
    }).catchAppError((appError) {
      Fluttertoast.showToast(msg: appError.message!);
    });
  }
}
