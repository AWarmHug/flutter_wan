import 'package:flutter_wan/data/zhihu/badge.dart';

import 'author.dart';

/// id : 10011455309
/// type : "comment"
/// url : "https://www.zhihu.com/api/v4/comments/10011455309"
/// content : "如果我们也投了小男孩，后来还收割他们的经济，我也无所谓他们是不是参拜"
/// featured : true
/// top : false
/// collapsed : false
/// is_author : false
/// is_delete : false
/// created_time : 1638886937
/// resource_type : "answer"
/// reviewing : false
/// allow_like : true
/// allow_delete : false
/// allow_reply : true
/// allow_vote : true
/// can_recommend : false
/// can_collapse : false
/// attached_info : "ggIGCAsQABgA"
/// author : {"role":"normal","member":{"id":"43a23381d79bcbec7209d1fb17081b30","url_token":"wee04","name":"wee04","avatar_url":"https://pic3.zhimg.com/v2-243a638c2ec173c90e5de44a1ca1574d.jpg?source=06d4cd63","avatar_url_template":"https://pic1.zhimg.com/v2-243a638c2ec173c90e5de44a1ca1574d.jpg?source=06d4cd63","is_org":false,"type":"people","url":"https://www.zhihu.com/api/v4/people/43a23381d79bcbec7209d1fb17081b30","user_type":"people","headline":"","badge":[],"gender":0,"is_advertiser":false,"vip_info":{"is_vip":false}}}
/// is_parent_author : false
/// vote_count : 1309
/// voting : false
/// liked : false
/// disliked : false

class AnswerComment {
  AnswerComment({
      this.id, 
      this.type, 
      this.url, 
      this.content, 
      this.featured, 
      this.top, 
      this.collapsed, 
      this.isAuthor, 
      this.isDelete, 
      this.createdTime, 
      this.resourceType, 
      this.reviewing, 
      this.allowLike, 
      this.allowDelete, 
      this.allowReply, 
      this.allowVote, 
      this.canRecommend, 
      this.canCollapse, 
      this.attachedInfo, 
      this.author, 
      this.isParentAuthor, 
      this.voteCount, 
      this.voting, 
      this.liked, 
      this.disliked,});

  AnswerComment.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    url = json['url'];
    content = json['content'];
    featured = json['featured'];
    top = json['top'];
    collapsed = json['collapsed'];
    isAuthor = json['is_author'];
    isDelete = json['is_delete'];
    createdTime = json['created_time'];
    resourceType = json['resource_type'];
    reviewing = json['reviewing'];
    allowLike = json['allow_like'];
    allowDelete = json['allow_delete'];
    allowReply = json['allow_reply'];
    allowVote = json['allow_vote'];
    canRecommend = json['can_recommend'];
    canCollapse = json['can_collapse'];
    attachedInfo = json['attached_info'];
    author = json['author'] != null ? AnswerAuthor.fromJson(json['author']) : null;
    isParentAuthor = json['is_parent_author'];
    voteCount = json['vote_count'];
    voting = json['voting'];
    liked = json['liked'];
    disliked = json['disliked'];
  }
  int? id;
  String? type;
  String? url;
  String? content;
  bool? featured;
  bool? top;
  bool? collapsed;
  bool? isAuthor;
  bool? isDelete;
  int? createdTime;
  String? resourceType;
  bool? reviewing;
  bool? allowLike;
  bool? allowDelete;
  bool? allowReply;
  bool? allowVote;
  bool? canRecommend;
  bool? canCollapse;
  String? attachedInfo;
  AnswerAuthor? author;
  bool? isParentAuthor;
  int? voteCount;
  bool? voting;
  bool? liked;
  bool? disliked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['url'] = url;
    map['content'] = content;
    map['featured'] = featured;
    map['top'] = top;
    map['collapsed'] = collapsed;
    map['is_author'] = isAuthor;
    map['is_delete'] = isDelete;
    map['created_time'] = createdTime;
    map['resource_type'] = resourceType;
    map['reviewing'] = reviewing;
    map['allow_like'] = allowLike;
    map['allow_delete'] = allowDelete;
    map['allow_reply'] = allowReply;
    map['allow_vote'] = allowVote;
    map['can_recommend'] = canRecommend;
    map['can_collapse'] = canCollapse;
    map['attached_info'] = attachedInfo;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['is_parent_author'] = isParentAuthor;
    map['vote_count'] = voteCount;
    map['voting'] = voting;
    map['liked'] = liked;
    map['disliked'] = disliked;
    return map;
  }

}

/// role : "normal"
/// member : {"id":"43a23381d79bcbec7209d1fb17081b30","url_token":"wee04","name":"wee04","avatar_url":"https://pic3.zhimg.com/v2-243a638c2ec173c90e5de44a1ca1574d.jpg?source=06d4cd63","avatar_url_template":"https://pic1.zhimg.com/v2-243a638c2ec173c90e5de44a1ca1574d.jpg?source=06d4cd63","is_org":false,"type":"people","url":"https://www.zhihu.com/api/v4/people/43a23381d79bcbec7209d1fb17081b30","user_type":"people","headline":"","badge":[],"gender":0,"is_advertiser":false,"vip_info":{"is_vip":false}}

class AnswerAuthor {
  AnswerAuthor({
      this.role, 
      this.member,});

  AnswerAuthor.fromJson(dynamic json) {
    role = json['role'];
    member = json['member'] != null ? Author.fromJson(json['member']) : null;
  }
  String? role;
  Author? member;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    if (member != null) {
      map['member'] = member?.toJson();
    }
    return map;
  }

}


/// is_vip : false

class Vip_info {
  Vip_info({
      this.isVip,});

  Vip_info.fromJson(dynamic json) {
    isVip = json['is_vip'];
  }
  bool? isVip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_vip'] = isVip;
    return map;
  }

}