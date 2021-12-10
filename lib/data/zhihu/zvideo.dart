import 'package:flutter_wan/data/zhihu/video.dart';

import 'author.dart';
import 'can_comment.dart';
import 'video_item.dart';

class ZVideo extends VideoItem{

  ZVideo.fromJson(dynamic json) {
    id = json['id'];
    contentId = json['content_id'];
    type = json['type'];
    title = json['title'];
    imageUrl = json['image_url'];
    description = json['description'];
    excerpt = json['excerpt'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['topics'] != null) {
      topics = [];
      json['topics'].forEach((v) {
        topics?.add(Topic.fromJson(v));
      });
    }
    mcnLinkcards = json['mcn_linkcards'];
    updatedAt = json['updated_at'];
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
    publishedAt = json['published_at'];
    playCount = json['play_count'];
    commentCount = json['comment_count'];
    voteupCount = json['voteup_count'];
    favlistsCount = json['favlists_count'];
    likedCount = json['liked_count'];
    shareCount = json['share_count'];
    bulletCount = json['bullet_count'];
    voting = json['voting'];
    isLiked = json['is_liked'];
    isReviewing = json['is_reviewing'];
    isUpdateReviewing = json['is_update_reviewing'];
    url = json['url'];
    commentPermission = json['comment_permission'];
    canComment = json['can_comment'] != null
        ? Can_comment.fromJson(json['can_comment'])
        : null;
    adminClosedComment = json['admin_closed_comment'];
    attachedInfo = json['attached_info'];
    isVisible = json['is_visible'];
    isLabeled = json['is_labeled'];
    isFavorited = json['is_favorited'];
    hasColumn = json['has_column'];
    contribute = json['contribute'] != null
        ? Contribute.fromJson(json['contribute'])
        : null;
    friendInteraction = json['friend_interaction'] != null
        ? Friend_interaction.fromJson(json['friend_interaction'])
        : null;
    if (json['interactive_tags'] != null) {
      interactiveTags = [];
      json['interactive_tags'].forEach((v) {
        interactiveTags?.add(Interactive_tags.fromJson(v));
      });
    }
  }

  String? title;
  String? imageUrl;
  String? description;
  String? excerpt;
  List<Topic>? topics;
  dynamic mcnLinkcards;
  int? updatedAt;
  Video? video;
  int? publishedAt;
  int? playCount;
  int? commentCount;
  int? voteupCount;
  int? favlistsCount;
  int? likedCount;
  int? shareCount;
  int? bulletCount;
  int? voting;
  bool? isLiked;
  bool? isReviewing;
  bool? isUpdateReviewing;
  String? url;
  String? commentPermission;
  Can_comment? canComment;
  bool? adminClosedComment;
  String? attachedInfo;
  bool? isLabeled;
  bool? isFavorited;
  bool? hasColumn;
  Contribute? contribute;
  Friend_interaction? friendInteraction;
  List<Interactive_tags>? interactiveTags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content_id'] = contentId;
    map['title'] = title;
    map['image_url'] = imageUrl;
    map['description'] = description;
    map['excerpt'] = excerpt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (topics != null) {
      map['topics'] = topics?.map((v) => v.toJson()).toList();
    }
    map['mcn_linkcards'] = mcnLinkcards;
    map['updated_at'] = updatedAt;
    if (video != null) {
      map['video'] = video?.toJson();
    }
    map['published_at'] = publishedAt;
    map['play_count'] = playCount;
    map['comment_count'] = commentCount;
    map['voteup_count'] = voteupCount;
    map['favlists_count'] = favlistsCount;
    map['liked_count'] = likedCount;
    map['share_count'] = shareCount;
    map['bullet_count'] = bulletCount;
    map['voting'] = voting;
    map['is_liked'] = isLiked;
    map['is_reviewing'] = isReviewing;
    map['is_update_reviewing'] = isUpdateReviewing;
    map['url'] = url;
    map['type'] = type;
    map['comment_permission'] = commentPermission;
    if (canComment != null) {
      map['can_comment'] = canComment?.toJson();
    }
    map['admin_closed_comment'] = adminClosedComment;
    map['attached_info'] = attachedInfo;
    map['is_visible'] = isVisible;
    map['is_labeled'] = isLabeled;
    map['is_favorited'] = isFavorited;
    map['has_column'] = hasColumn;
    if (contribute != null) {
      map['contribute'] = contribute?.toJson();
    }
    if (friendInteraction != null) {
      map['friend_interaction'] = friendInteraction?.toJson();
    }
    if (interactiveTags != null) {
      map['interactive_tags'] =
          interactiveTags?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "热评满满"

class Interactive_tags {
  Interactive_tags({
    this.text,
  });

  Interactive_tags.fromJson(dynamic json) {
    text = json['text'];
  }

  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    return map;
  }
}


class Friend_interaction {
  Friend_interaction({
    this.upvoteCnt,
    this.upvoteMembers,
  });

  Friend_interaction.fromJson(dynamic json) {
    upvoteCnt = json['upvote_cnt'];
    if (json['upvote_members'] != null) {
      upvoteMembers = [];
      json['upvote_members'].forEach((v) {
        upvoteMembers?.add(v);
      });
    }
  }

  int? upvoteCnt;
  List<String>? upvoteMembers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['upvote_cnt'] = upvoteCnt;
    if (upvoteMembers != null) {
      map['upvote_members'] = upvoteMembers?.map((v) => v).toList();
    }
    return map;
  }
}

class Contribute {
  Contribute({
    this.contributeList,
    this.latestContribute,
    this.hasNewFail,
    this.unfinishedCount,
    this.visitorCirculateCount,
    this.totals,
  });

  Contribute.fromJson(dynamic json) {
    if (json['contribute_list'] != null) {
      contributeList = [];
      json['contribute_list'].forEach((v) {
        contributeList?.add(v);
      });
    }
    latestContribute = json['latest_contribute'];
    hasNewFail = json['has_new_fail'];
    unfinishedCount = json['unfinished_count'];
    visitorCirculateCount = json['visitor_circulate_count'];
    totals = json['totals'];
  }

  List<dynamic>? contributeList;
  dynamic latestContribute;
  bool? hasNewFail;
  int? unfinishedCount;
  int? visitorCirculateCount;
  int? totals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contributeList != null) {
      map['contribute_list'] = contributeList?.map((v) => v.toJson()).toList();
    }
    map['latest_contribute'] = latestContribute;
    map['has_new_fail'] = hasNewFail;
    map['unfinished_count'] = unfinishedCount;
    map['visitor_circulate_count'] = visitorCirculateCount;
    map['totals'] = totals;
    return map;
  }
}


class Topic {
  Topic({
    this.url,
    this.type,
    this.id,
    this.name,
    this.topicType,
  });

  Topic.fromJson(dynamic json) {
    url = json['url'];
    type = json['type'];
    id = json['id'];
    name = json['name'];
    topicType = json['topic_type'];
  }

  String? url;
  String? type;
  String? id;
  String? name;
  String? topicType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['type'] = type;
    map['id'] = id;
    map['name'] = name;
    map['topic_type'] = topicType;
    return map;
  }
}

