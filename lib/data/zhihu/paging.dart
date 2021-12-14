/// is_end : false
/// is_start : true
/// next : "https://www.zhihu.com/api/v4/zvideo-tabs/tabs/choice/feeds/recommend?include=creation_relationship&limit=12&offset=24&trans="
/// previous : ""
/// totals : 0

class Paging {
  Paging({
    this.isEnd = false,
    this.isStart = false,
    this.next,
    this.previous,
    this.totals = 0,
  });

  Paging.fromJson(dynamic json) {
    isEnd = json['is_end'];
    isStart = json['is_start'];
    next = json['next'];
    previous = json['previous'];
    totals = json['totals'];
  }

  bool? isEnd = false;
  bool? isStart = false;
  String? next;
  String? previous;
  int? totals = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_end'] = isEnd;
    map['is_start'] = isStart;
    map['next'] = next;
    map['previous'] = previous;
    map['totals'] = totals;
    return map;
  }
}
