
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';

import '../../http.dart';

class ProjectRepository{

  Future<ResponseWan<List<Tree>>> loadProjectTrees() async {
    return Http.get("project/tree/json");
  }

  Future<ResponseWan<ListData<Article>>> loadProjectList(int pageNum,int? cid) async {
    return Http.get("project/list/$pageNum/json?cid=$cid");
  }

}