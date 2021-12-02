import 'article.dart';
import 'banner.dart';
import 'collect.dart';
import 'data_list.dart';
import 'navigation.dart';
import 'search.dart';
import 'tree.dart';
import 'user.dart';

/// data : {"curPage":1,"datas":[],"offset":0,"over":false,"pageCount":554,"size":20,"total":11072}
/// errorCode : 0
/// errorMsg : ""

class ResponseWan<T> {
  late final T? data;
  late final int errorCode;
  late final String errorMsg;

  ResponseWan({this.data, required this.errorCode, required this.errorMsg});

  bool get isSuccess {
    return errorCode == 0;
  }

  ResponseWan.fromJson(dynamic json) {
    errorCode = json["errorCode"];
    errorMsg = json["errorMsg"];

    if(T.toString() == ("dynamic")) {
      data = json["data"];
    }

    if (T.toString() == ("ListData<Article>")) {
      data = json["data"] != null
          ? ListData<Article>.fromJson(json["data"]) as T
          : null;
    }

    if (T.toString() == ("ListData<Collect>")) {
      data = json["data"] != null
          ? ListData<Collect>.fromJson(json["data"]) as T
          : null;
    }

    if (T.toString().contains("List")) {
      if (json["data"] != null) {
        if (T.toString() == "List<BannerItem>") {
          var d = <BannerItem>[];
          json["data"].forEach((v) {
            d.add(BannerItem.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<Tree>") {
          var d = <Tree>[];
          json["data"].forEach((v) {
            d.add(Tree.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<HotKey>") {
          var d = <HotKey>[];
          json["data"].forEach((v) {
            d.add(HotKey.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<Navigation>") {
          var d = <Navigation>[];
          json["data"].forEach((v) {
            d.add(Navigation.fromJson(v));
          });
          data = d as T;
        }
      }
    }

    if (T.toString() == "User") {
      data = json["data"] != null ? User.fromJson(json["data"]) as T : null;
    }

    if (T.toString() == "UserInfo") {
      data = json["data"] != null ? UserInfo.fromJson(json["data"]) as T : null;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      if (data is ListData?) {
        ListData n = data as ListData;
        map["data"] = n.toJson();
      }
    }
    map["errorCode"] = errorCode;
    map["errorMsg"] = errorMsg;
    return map;
  }
}
