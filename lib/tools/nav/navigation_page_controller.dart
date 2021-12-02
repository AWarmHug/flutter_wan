import 'package:flutter_wan/data/navigation.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/tools/wx_article/wx_article_repository.dart';
import 'package:get/get.dart';

import 'navigation_response.dart';

class NavigationController extends GetxController {

  NavigationRepository _repository = NavigationRepository();

 Rx<Resource<List<Navigation>>>  navigations = Rx(Resource.loading());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadNavigation();
  }

  void loadNavigation() async {
    navigations.value=Resource.loading();

    ResponseWan<List<Navigation>> responseWan =
        await _repository.loadNavigation();
    if (responseWan.isSuccess) {
      navigations.value=Resource.success(responseWan.data!);
    } else {
      navigations.value=Resource.error("失败");
    }
  }
}
