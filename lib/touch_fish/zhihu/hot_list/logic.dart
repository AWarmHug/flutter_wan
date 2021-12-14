import 'package:flutter_wan/data/zhihu/hot_list_feed.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';
import 'package:flutter_wan/extensions.dart';

import 'state.dart';

class QuestionLogic extends GetxController {
  final QuestionState state = QuestionState();

  RefreshController refreshController=RefreshController();

  @override
  void onInit() {
    super.onInit();
    refreshHotListWeb();
  }


  void refreshHotListWeb(){
    _loadHotListWeb().then((value) {
      refreshController.refreshSuccess();
    }).catchAppError((appError) {
      refreshController.refreshError(appError.code);
    });
  }

  void loadHotListWeb(){
    refreshController.loadSuccess();
  }

  Future<void> _loadHotListWeb() async {
    var response = await Http.get<List<HotListFeed>>(
        "v3/feed/topstory/hot-lists/total?limit=50&mobile=true");
    if (response.isSuccess) {
      if (response.data != null && response.data!.isNotEmpty) {
        state.hotListFeed = response.data!;
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(response.error!);
    }
  }
}
