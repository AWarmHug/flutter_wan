import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/tree/state.dart';
import 'package:flutter_wan/tree/repository.dart';
import 'package:get/get.dart';

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
