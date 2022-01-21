import 'package:get/get.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final state = MainState();


  void setSelectedIndex(int selectIndex){
    state.selectedIndex=selectIndex;
    update();
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }



}
