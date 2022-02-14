import 'package:flutter_wan/data/tree.dart';
import 'package:get/get.dart';

import 'repository.dart';
import 'state.dart';

class TreePageController extends GetxController {
  final _treeResponse = TreeRepository();
  final state = TreeState();

  void loadTree() {
    _treeResponse.loadTree().then((value) {
      if(value.isSuccess) {
        state.trees = value.data;
        if (value.data != null) {
          setSelectedTree(value.data!.first);
        }
      }
    });
  }

  void setSelectedTree(Tree tree) {
    state.selectedTree.value = tree;
  }


  @override
  void onInit() {
    super.onInit();
  }
}
