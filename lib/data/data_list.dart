import 'article.dart';
import 'collect.dart';

/// curPage : 1
/// datas : []
/// offset : 0
/// over : false
/// pageCount : 554
/// size : 20
/// total : 11072
class ResBody {
  Map<String, dynamic> toJson() => {};
}

class ListData<T> with ResBody {
  late int curPage;
  late List<T> datas;
  late int offset;
  late bool over;
  late int pageCount;
  late int size;
  late int total;

  ListData(
      {required this.curPage,
      required this.datas,
      required this.offset,
      required this.over,
      required this.pageCount,
      required this.size,
      required this.total});

  ListData.fromJson(dynamic json) {
    curPage = json["curPage"];
    if (json["datas"] != null) {
      datas = [];
      json["datas"].forEach((v) {
        if (T.toString() == "Article") {
          datas.add(Article.fromJson(v) as T);
        }
        if (T.toString() == "Collect") {
          datas.add(Collect.fromJson(v) as T);
        }
      });
    }
    offset = json["offset"];
    over = json["over"];
    pageCount = json["pageCount"];
    size = json["size"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["curPage"] = curPage;
    if (datas != null) {
      map["datas"] = datas.map((v) {
        if (v is Article) {
          return v.toJson();
        } else {
          return {};
        }
      }).toList();
    }
    map["offset"] = offset;
    map["over"] = over;
    map["pageCount"] = pageCount;
    map["size"] = size;
    map["total"] = total;
    return map;
  }
}
