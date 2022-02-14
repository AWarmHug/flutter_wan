import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/navigation.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';

import '../../http.dart';

class NavigationRepository {

  Future<ResponseWan<List<Navigation>>> loadNavigation() async {
    return Http.get("navi/json");
  }


}
