import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';

import '../../http.dart';

class WXArticleRepository {
  Future<ResponseWan<List<Tree>>> loadWXArticleChapters() async {
    return Http.get("wxarticle/chapters/json");
  }

  Future<ResponseWan<ListData<Article>>> loadWXArticleList(
      int id, int pageNum,
      {String? keyword}) async {
    return Http.get("wxarticle/list/$id/$pageNum/json",
        queryParameters: {"k": keyword});
  }
}
