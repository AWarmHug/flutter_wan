import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:get/get.dart';

import 'wx_article_repository.dart';

class WxArticleController extends GetxController {
  WXArticleRepository _repository = WXArticleRepository();

  List<Tree> trees = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadWXArticleChapters();
  }

  void loadWXArticleChapters() async {
    ResponseWan<List<Tree>> responseWan =
        await _repository.loadWXArticleChapters();
    if (responseWan.isSuccess) {
      trees
        ..clear()
        ..addAll(responseWan.data!);
      update();
    } else {}
  }
}
