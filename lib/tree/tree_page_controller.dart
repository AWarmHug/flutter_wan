import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/tree/state.dart';
import 'package:flutter_wan/tree/tree_repository.dart';
import 'package:get/get.dart';

class TreePageController extends GetxController {
  final _treeResponse = TreeRepository();
  final state = TreeState();

  void loadTree() {
    _treeResponse.loadTree().then((value) {
      state.trees.value = value;
      if (value.data != null) {
        setSelectedTree(value.data!.first);
      }
    });
  }

  void setSelectedTree(Tree tree) {
    state.selectedTree.value = tree;
  }

  Future<ResponseWan<ListData<Article>>> loadTreeList(int pageNum, Tree tree) {
    return _treeResponse.loadTreeList(pageNum, tree.id!);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
