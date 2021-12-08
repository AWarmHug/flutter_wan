
import 'badge.dart';

class Author {
  Author({
    this.isFollowed,
    this.avatarUrlTemplate,
    this.uid,
    this.userType,
    this.isFollowing,
    this.urlToken,
    this.id,
    this.description,
    this.name,
    this.isAdvertiser,
    this.headline,
    this.gender,
    this.url,
    this.avatarUrl,
    this.isOrg,
    this.type,
    this.badge,
    this.badgeV2,
  });

  Author.fromJson(dynamic json) {
    isFollowed = json['is_followed'];
    avatarUrlTemplate = json['avatar_url_template'];
    uid = json['uid'];
    userType = json['user_type'];
    isFollowing = json['is_following'];
    urlToken = json['url_token'];
    id = json['id'];
    description = json['description'];
    name = json['name'];
    isAdvertiser = json['is_advertiser'];
    headline = json['headline'];
    gender = json['gender'];
    url = json['url'];
    avatarUrl = json['avatar_url'];
    isOrg = json['is_org'];
    type = json['type'];
    badge = json['badge'];
    badgeV2 =
    json['badge_v2'] != null ? Badge_v2.fromJson(json['badge_v2']) : null;
  }

  bool? isFollowed;
  String? avatarUrlTemplate;
  String? uid;
  String? userType;
  bool? isFollowing;
  String? urlToken;
  String? id;
  String? description;
  String? name;
  bool? isAdvertiser;
  String? headline;
  int? gender;
  String? url;
  String? avatarUrl;
  bool? isOrg;
  String? type;
  dynamic badge;
  Badge_v2? badgeV2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_followed'] = isFollowed;
    map['avatar_url_template'] = avatarUrlTemplate;
    map['uid'] = uid;
    map['user_type'] = userType;
    map['is_following'] = isFollowing;
    map['url_token'] = urlToken;
    map['id'] = id;
    map['description'] = description;
    map['name'] = name;
    map['is_advertiser'] = isAdvertiser;
    map['headline'] = headline;
    map['gender'] = gender;
    map['url'] = url;
    map['avatar_url'] = avatarUrl;
    map['is_org'] = isOrg;
    map['type'] = type;
    map['badge'] = badge;
    if (badgeV2 != null) {
      map['badge_v2'] = badgeV2?.toJson();
    }
    return map;
  }
}
