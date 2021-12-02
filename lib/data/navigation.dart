import 'article.dart';

/// articles : []
/// cid : 272
/// name : "常用网站"

class Navigation {
  Navigation({
      this.articles, 
      this.cid, 
      this.name,});

  Navigation.fromJson(dynamic json) {
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Article.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }
  List<Article>? articles;
  int? cid;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    map['cid'] = cid;
    map['name'] = name;
    return map;
  }

}