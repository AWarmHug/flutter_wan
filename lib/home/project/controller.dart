import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:get/get.dart';

import 'repository.dart';
import 'state.dart';

class ProjectPageController extends GetxController {
  final state = ProjectPageState();
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
    } else {}
  }
}
