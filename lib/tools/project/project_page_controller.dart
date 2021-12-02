import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/tools/project/project_repository.dart';
import 'package:get/get.dart';

class ProjectPageController extends GetxController {
  ProjectRepository _repository = ProjectRepository();

  Rx<Resource<List<Tree>>> trees = Rx(Resource.loading());

  Rx<Resource<ListData<Article>>> list = Rx(Resource.loading());

  @override
  void onInit() {
    super.onInit();
    loadWXArticleList();
  }

  void loadWXArticleList() async {
    trees.value = Resource.loading();
    ResponseWan<List<Tree>> responseWan = await _repository.loadProjectTrees();
    if (responseWan.isSuccess && responseWan.data != null) {
      trees.value = Resource.success(responseWan.data!);
    } else {
      trees.value = Resource.error("发生错误");
    }
  }

  void loadProjectList(int cid) async {
    list.value = Resource.loading();
    ResponseWan<ListData<Article>> responseWan =
        await _repository.loadProjectList(cid);
    if (responseWan.isSuccess && responseWan.data != null) {
      list.value = Resource.success(responseWan.data!);
    } else {
      list.value = Resource.error("发生错误");
    }
  }
}
