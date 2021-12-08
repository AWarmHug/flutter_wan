/// type : "identity"
/// detail_type : "identity"
/// title : "认证"
/// description : "生活领域答主"
/// url : "https://www.zhihu.com/account/verification/intro"
/// sources : []
/// icon : ""
/// night_icon : ""

class BadgeV2Item {
  BadgeV2Item({
      this.type, 
      this.detailType, 
      this.title, 
      this.description, 
      this.url, 
      this.sources, 
      this.icon, 
      this.nightIcon,});

  BadgeV2Item.fromJson(dynamic json) {
    type = json['type'];
    detailType = json['detail_type'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(v);
      });
    }
    icon = json['icon'];
    nightIcon = json['night_icon'];
  }
  String? type;
  String? detailType;
  String? title;
  String? description;
  String? url;
  List<String>? sources;
  String? icon;
  String? nightIcon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['detail_type'] = detailType;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    if (sources != null) {
      map['sources'] = sources?.map((v) => v).toList();
    }
    map['icon'] = icon;
    map['night_icon'] = nightIcon;
    return map;
  }

}