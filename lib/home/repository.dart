import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/banner.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';

import '../http.dart';

class HomePageRepository {

  Future<ResponseWan<List<BannerItem>>> loadBanner() async {
    return Http.get<List<BannerItem>>("banner/json");
  }

  Future<ResponseWan<ListData<Article>>> loadArticleList(int pageNum) async {
    return Http.get<ListData<Article>>("article/list/$pageNum/json");
  }


}