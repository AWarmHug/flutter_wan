import 'package:flutter_wan/data/zhihu/paging.dart';
import 'package:flutter_wan/data/zhihu/video_item.dart';
import 'package:get/get.dart';

import '../../../http.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Paging? paging;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadVideo();
  }

  void loadVideo() async{

    String path="v4/zvideo-tabs/tabs/choice/feeds/recommend?include=creation_relationship&limit=20&offset=0&trans=";
    if(paging!=null&&paging!.isEnd==false&&paging!.next!=null) {
      path=paging!.next!;
    }else{

    }

    var response = await Http.get<List<VideoItem>>(path);

    if(response.isSuccess){
      state.videos.addAll(response.data!);
      paging=response.paging;
    }else{

    }
    update();

  }




}
