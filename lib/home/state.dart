import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/banner.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../status.dart';

class HomePageState {
  Rx<Resource<List<BannerItem>>> banners = Rx(Resource.loading());

  Rx<Status> _refresh = Status.LOADING.obs;
  Status get refresh => _refresh.value;
  set refresh(Status value) => _refresh.value = value;

  Rx<Status> loadingMore = Status.LOADING.obs;

  RxList<Article> articles = <Article>[].obs;
}
