/// type : "identity"
/// topics : null
/// description : "生活领域答主"

class Badge {
  Badge({
      this.type, 
      this.topics, 
      this.description,});

  Badge.fromJson(dynamic json) {
    type = json['type'];
    topics = json['topics'];
    description = json['description'];
  }
  String? type;
  dynamic topics;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['topics'] = topics;
    map['description'] = description;
    return map;
  }

}

class Badge_v2 {
  Badge_v2({
    this.title,
    this.mergedBadges,
    this.detailBadges,
    this.icon,
    this.nightIcon,
  });

  Badge_v2.fromJson(dynamic json) {
    title = json['title'];
    if (json['merged_badges'] != null) {
      mergedBadges = [];
      json['merged_badges'].forEach((v) {
        mergedBadges?.add(BadgeV2Item.fromJson(v));
      });
    }
    if (json['detail_badges'] != null) {
      detailBadges = [];
      json['detail_badges'].forEach((v) {
        detailBadges?.add(BadgeV2Item.fromJson(v));
      });
    }
    icon = json['icon'];
    nightIcon = json['night_icon'];
  }

  String? title;
  List<BadgeV2Item>? mergedBadges;
  List<BadgeV2Item>? detailBadges;
  String? icon;
  String? nightIcon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (mergedBadges != null) {
      map['merged_badges'] = mergedBadges?.map((v) => v.toJson()).toList();
    }
    if (detailBadges != null) {
      map['detail_badges'] = detailBadges?.map((v) => v.toJson()).toList();
    }
    map['icon'] = icon;
    map['night_icon'] = nightIcon;
    return map;
  }
}


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
  List<dynamic>? sources;
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