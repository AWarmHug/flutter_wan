import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';

import '../../http.dart';

class TreeRepository {

  Future<ResponseWan<List<Tree>>> loadTree() async {
    return Http.get("tree/json");
  }

  Future<ResponseWan<ListData<Article>>> loadTreeList(int pageNum,int cid) async {
    return Http.get<ListData<Article>>("article/list/$pageNum/json?cid=$cid");
  }

}
