import 'author.dart';
import 'can_comment.dart';
import 'question.dart';
import 'relationship.dart';

/// relationship : {"voting":0,"is_thanked":false,"is_nothelp":false,"upvoted_followee_ids":[]}
/// mark_infos : []
/// excerpt : "以往我觉得2000万是天文数字，没想到头部的价值如此之高，还能随200万进去，当然2000万分期付款，其实很有可能就是边赚边付，付着付着就没多少了，但是一口气拿出200万的现金，实在是看的有点羡慕这个现金流的能力。今天我几乎所有的群都在讨论这件事，可以看出这次花钱消灾所带来的影响有多大了，我…"
/// created_time : 1639051852
/// updated_time : 1639052153
/// id : 2264013201
/// voteup_count : 1160
/// can_comment : {"status":true,"reason":""}
/// author : {"is_followed":false,"badge":[{"type":"identity","description":"动画盐究员"}],"name":"大狸","url":"https://api.zhihu.com/people/9cc2f51741c9bb8fa476b261fd89cc91","url_token":"pai-da-wei-82","user_type":"people","headline":"一只兴趣使然的颜控狸","avatar_url":"https://pic1.zhimg.com/v2-26467f46da7fd386d52b9a01dea0fc3b_720w.jpg","is_following":false,"is_org":false,"gender":1,"type":"people","id":"9cc2f51741c9bb8fa476b261fd89cc91"}
/// url : "https://api.zhihu.com/answers/2264013201"
/// comment_permission : "all"
/// question : {"author":{"is_followed":false,"badge":[],"name":"cc小伟","url":"https://api.zhihu.com/people/46002ffc26b33b0914a57ffac670a6ee","url_token":"ccxiao-wei","user_type":"people","headline":"化工学生","avatar_url":"https://pic1.zhimg.com/v2-c5d0b789d982bfd5220f8d05026b4d47_720w.jpg","is_following":false,"is_org":false,"gender":1,"type":"people","id":"46002ffc26b33b0914a57ffac670a6ee"},"bound_topic_ids":[128,1522,26323,182424,700191],"title":"如何评价 UP 主 LexBurner 被判赔偿 B 站 2000 万，B 站将解封其账号及直播间？","excerpt":"","answer_count":1103,"created":1639047159,"url":"https://api.zhihu.com/questions/504894744","comment_count":122,"is_following":false,"follower_count":2193,"type":"question","id":504894744}
/// preview_type : "default"
/// content : "<p data-pid=\"BwvuYTSx\">以往我觉得2000万是天文数字，没想到头部的价值如此之高，还能随200万进去，当然2000万分期付款，其实很有可能就是边赚边付，付着付着就没多少了，但是一口气拿出200万的现金，实在是看的有点羡慕这个现金流的能力。</p><p data-pid=\"ObTm0xzy\">今天我几乎所有的群都在讨论这件事，可以看出这次花钱消灾所带来的影响有多大了，我主要是很好奇回归之后，该怎么去面对舆论，反对声还是十分大的，用时间磨灭？还是控评控弹幕？或是转向生活区？感觉都要面临很多压力，但是能回来肯定是比赚不到钱好很多，爬都要爬回来才是，毕竟流量时代，流量=money，大几百万粉谁也舍不得丢了。</p><p data-pid=\"YFALkj69\">只是有点庞大的虚拟数字兜底，还要让自己的心态跟得上才行，要不然膨胀一个完一个，好像谁都没逃脱这个宿命。</p><p data-pid=\"3yDGzVg5\">最后看到图上的称呼我是真的绷不住了。。。</p><figure data-size=\"normal\"><img src=\"https://pic4.zhimg.com/v2-5aab4795b252abfe8b596f9c60ff8bb6_720w.jpg\" data-rawwidth=\"886\" data-rawheight=\"1613\" data-size=\"normal\" data-default-watermark-src=\"https://pic4.zhimg.com/v2-c05e470b85c108640fa4166034c403a1_720w.jpg\" class=\"origin_image zh-lightbox-thumb\" width=\"886\" data-original=\"https://pic2.zhimg.com/v2-5aab4795b252abfe8b596f9c60ff8bb6_r.jpg\"></figure><p></p>"
/// comment_count : 157
/// reshipment_settings : "disallowed"
/// thanks_count : 52
/// excerpt_new : "以往我觉得2000万是天文数字，没想到头部的价值如此之高，还能随200万进去，当然2000万分期付款，其实很有可能就是边赚边付，付着付着就没多少了，但是一口气拿出200万的现金，实在是看的有点羡慕这个现金流的能力。今天我几乎所有的群都在讨论这件事，可以看出这次花钱消灾所带来的影响有多大了，我…"
/// preview_text : ""
/// is_copyable : false
/// type : "answer"
/// thumbnail : "https://pic4.zhimg.com/v2-071ecb929efdeacb8c1c0a8ee76c8aca_200x112.jpg"

class Target {
  Target({
    this.relationship,
    this.markInfos,
    this.excerpt,
    this.createdTime,
    this.updatedTime,
    this.id,
    this.voteupCount,
    this.canComment,
    this.author,
    this.url,
    this.commentPermission,
    this.question,
    this.previewType,
    this.content,
    this.commentCount,
    this.reshipmentSettings,
    this.thanksCount,
    this.excerptNew,
    this.previewText,
    this.isCopyable,
    this.type,
    this.thumbnail,});

  Target.fromJson(dynamic json) {
    relationship = json['relationship'] != null ? Relationship.fromJson(json['relationship']) : null;
    if (json['mark_infos'] != null) {
      markInfos = [];
      json['mark_infos'].forEach((v) {
        markInfos?.add(v);
      });
    }
    excerpt = json['excerpt'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    id = json['id'];
    voteupCount = json['voteup_count'];
    canComment = json['can_comment'] != null ? Can_comment.fromJson(json['can_comment']) : null;
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    url = json['url'];
    commentPermission = json['comment_permission'];
    question = json['question'] != null ? Question.fromJson(json['question']) : null;
    previewType = json['preview_type'];
    content = json['content'];
    commentCount = json['comment_count'];
    reshipmentSettings = json['reshipment_settings'];
    thanksCount = json['thanks_count'];
    excerptNew = json['excerpt_new'];
    previewText = json['preview_text'];
    isCopyable = json['is_copyable'];
    type = json['type'];
    thumbnail = json['thumbnail'];
  }
  Relationship? relationship;
  List<dynamic>? markInfos;
  String? excerpt;
  int? createdTime;
  int? updatedTime;
  int? id;
  int? voteupCount;
  Can_comment? canComment;
  Author? author;
  String? url;
  String? commentPermission;
  Question? question;
  String? previewType;
  String? content;
  int? commentCount;
  String? reshipmentSettings;
  int? thanksCount;
  String? excerptNew;
  String? previewText;
  bool? isCopyable;
  String? type;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    if (markInfos != null) {
      map['mark_infos'] = markInfos?.map((v) => v.toJson()).toList();
    }
    map['excerpt'] = excerpt;
    map['created_time'] = createdTime;
    map['updated_time'] = updatedTime;
    map['id'] = id;
    map['voteup_count'] = voteupCount;
    if (canComment != null) {
      map['can_comment'] = canComment?.toJson();
    }
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['url'] = url;
    map['comment_permission'] = commentPermission;
    if (question != null) {
      map['question'] = question?.toJson();
    }
    map['preview_type'] = previewType;
    map['content'] = content;
    map['comment_count'] = commentCount;
    map['reshipment_settings'] = reshipmentSettings;
    map['thanks_count'] = thanksCount;
    map['excerpt_new'] = excerptNew;
    map['preview_text'] = previewText;
    map['is_copyable'] = isCopyable;
    map['type'] = type;
    map['thumbnail'] = thumbnail;
    return map;
  }

}