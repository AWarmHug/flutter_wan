import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/tools/project/repository.dart';
import 'package:flutter_wan/tools/project/state.dart';
import 'package:get/get.dart';

class ProjectPageController extends GetxController {
  final state=ProjectPageState();
  ProjectRepository _repository = ProjectRepository();

  @override
  void onInit() {
    super.onInit();
    loadTreeList();
  }

  void loadTreeList() async {
    ResponseWan<List<Tree>> responseWan = await _repository.loadProjectTrees();
    if (responseWan.isSuccess && responseWan.data != null) {
      state.trees = responseWan.data!;
    } else {
    }
  }

}
