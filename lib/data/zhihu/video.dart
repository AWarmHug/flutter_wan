import 'package:flutter_wan/extensions.dart';

import 'badge.dart';
import 'play_list.dart';

class Video {
  Video({
    this.videoId,
    this.width,
    this.height,
    this.duration,
    this.type,
    this.thumbnail,
    this.playCount,
    this.isOpenBullet,
    this.playlist,
    this.playlistV2,
    this.status,
    this.isPaid,
    this.isTrial,
    this.components,
    this.beginFrame,
  });

  Video.fromJson(dynamic json) {
    videoId = json['video_id'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'].toString().toDouble();
    type = json['type'];
    thumbnail = json['thumbnail'];
    playCount = json['play_count'];
    isOpenBullet = json['is_open_bullet'];
    playlist =
        json['playlist'] != null ? Playlist.fromJson(json['playlist']) : null;
    playlistV2 = json['playlist_v2'] != null
        ? Playlist_v2.fromJson(json['playlist_v2'])
        : null;
    status = json['status'];
    isPaid = json['is_paid'];
    isTrial = json['is_trial'];
    if (json['components'] != null) {
      components = [];
      json['components'].forEach((v) {
        components?.add(Components.fromJson(v));
      });
    }
    beginFrame = json['begin_frame'] != null
        ? Begin_frame.fromJson(json['begin_frame'])
        : null;
  }

  String? videoId;
  int? width;
  int? height;
  double? duration;
  String? type;
  String? thumbnail;
  int? playCount;
  bool? isOpenBullet;
  Playlist? playlist;
  Playlist_v2? playlistV2;
  String? status;
  bool? isPaid;
  bool? isTrial;
  List<Components>? components;
  Begin_frame? beginFrame;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video_id'] = videoId;
    map['width'] = width;
    map['height'] = height;
    map['duration'] = duration;
    map['type'] = type;
    map['thumbnail'] = thumbnail;
    map['play_count'] = playCount;
    map['is_open_bullet'] = isOpenBullet;
    map['playlist'] = playlist;
    map['playlist_v2'] = playlistV2;
    map['status'] = status;
    map['is_paid'] = isPaid;
    map['is_trial'] = isTrial;
    if (components != null) {
      map['components'] = components?.map((v) => v.toJson()).toList();
    }
    if (beginFrame != null) {
      map['begin_frame'] = beginFrame?.toJson();
    }
    return map;
  }

  PlayItem? getPlayItem() {
    return playlistV2?.fhd ??
        playlistV2?.hd ??
        playlistV2?.ld ??
        playlistV2?.sd ??
        playlist?.fhd ??
        playlist?.hd ??
        playlist?.ld ??
        playlist?.sd ??
        null;
  }
}

class Video_info {
  Video_info({
    this.videoId,
    this.width,
    this.height,
    this.duration,
    this.type,
    this.thumbnail,
    this.playCount,
    this.isOpenBullet,
    this.playlist,
    this.playlistV2,
    this.status,
    this.isPaid,
    this.isTrial,
    this.beginFrame,
  });

  Video_info.fromJson(dynamic json) {
    videoId = json['video_id'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    type = json['type'];
    thumbnail = json['thumbnail'];
    playCount = json['play_count'];
    isOpenBullet = json['is_open_bullet'];
    playlist =json['playlist'] != null
        ? Playlist.fromJson(json['playlist'])
        : null;
    playlistV2 = json['playlist_v2'] != null
        ? Playlist_v2.fromJson(json['playlist_v2'])
        : null;
    status = json['status'];
    isPaid = json['is_paid'];
    isTrial = json['is_trial'];
    beginFrame = json['begin_frame'] != null
        ? Begin_frame.fromJson(json['begin_frame'])
        : null;
  }

  String? videoId;
  int? width;
  int? height;
  double? duration;
  String? type;
  String? thumbnail;
  int? playCount;
  bool? isOpenBullet;
  Playlist? playlist;
  Playlist_v2? playlistV2;
  String? status;
  bool? isPaid;
  bool? isTrial;
  Begin_frame? beginFrame;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video_id'] = videoId;
    map['width'] = width;
    map['height'] = height;
    map['duration'] = duration;
    map['type'] = type;
    map['thumbnail'] = thumbnail;
    map['play_count'] = playCount;
    map['is_open_bullet'] = isOpenBullet;
    map['playlist'] = playlist;
    map['playlist_v2'] = playlistV2;
    map['status'] = status;
    map['is_paid'] = isPaid;
    map['is_trial'] = isTrial;
    if (beginFrame != null) {
      map['begin_frame'] = beginFrame?.toJson();
    }
    return map;
  }
}

class Begin_frame {
  Begin_frame({
    this.FHD,
    this.HD,
    this.LD,
    this.SD,
  });

  Begin_frame.fromJson(dynamic json) {
    FHD = json['FHD'];
    HD = json['HD'];
    LD = json['LD'];
    SD = json['SD'];
  }

  String? FHD;
  String? HD;
  String? LD;
  String? SD;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FHD'] = FHD;
    map['HD'] = HD;
    map['LD'] = LD;
    map['SD'] = SD;
    return map;
  }
}

class Components {
  Components({
    this.type,
    this.content,
    this.triggerCondition,
  });

  Components.fromJson(dynamic json) {
    type = json['type'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    triggerCondition = json['trigger_condition'] != null
        ? Trigger_condition.fromJson(json['trigger_condition'])
        : null;
  }

  String? type;
  Content? content;
  Trigger_condition? triggerCondition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (content != null) {
      map['content'] = content?.toJson();
    }
    if (triggerCondition != null) {
      map['trigger_condition'] = triggerCondition?.toJson();
    }
    return map;
  }
}

class Content {
  Content({
    this.user,
  });

  Content.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
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

  User.fromJson(dynamic json) {
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

class Trigger_condition {
  Trigger_condition({
    this.compact,
    this.full,
  });

  Trigger_condition.fromJson(dynamic json) {
    compact =
        json['compact'] != null ? Compact.fromJson(json['compact']) : null;
    full = json['full'] != null ? Full.fromJson(json['full']) : null;
  }

  Compact? compact;
  Full? full;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (compact != null) {
      map['compact'] = compact?.toJson();
    }
    if (full != null) {
      map['full'] = full?.toJson();
    }
    return map;
  }
}

class Compact {
  Compact({
    this.type,
    this.condition,
  });

  Compact.fromJson(dynamic json) {
    type = json['type'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  String? type;
  Condition? condition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (condition != null) {
      map['condition'] = condition?.toJson();
    }
    return map;
  }
}

class Condition {
  Condition({
    this.durationMillis,
    this.elaspedMillis,
  });

  Condition.fromJson(dynamic json) {
    durationMillis = json['duration_millis'];
    elaspedMillis = json['elasped_millis'];
  }

  int? durationMillis;
  int? elaspedMillis;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration_millis'] = durationMillis;
    map['elasped_millis'] = elaspedMillis;
    return map;
  }
}

class Full {
  Full({
    this.type,
    this.condition,
  });

  Full.fromJson(dynamic json) {
    type = json['type'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }

  String? type;
  Condition? condition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (condition != null) {
      map['condition'] = condition?.toJson();
    }
    return map;
  }
}
