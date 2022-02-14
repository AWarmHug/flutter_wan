import 'package:flutter_wan/data/article.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PageItemState {
  PageItemState() {
    ///Initialize variables
  }

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  set articles(List<Article> value) {
    _articles = value;
  }
}
