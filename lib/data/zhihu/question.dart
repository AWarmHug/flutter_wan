import 'author.dart';

/// author : {"is_followed":false,"badge":[],"name":"cc小伟","url":"https://api.zhihu.com/people/46002ffc26b33b0914a57ffac670a6ee","url_token":"ccxiao-wei","user_type":"people","headline":"化工学生","avatar_url":"https://pic1.zhimg.com/v2-c5d0b789d982bfd5220f8d05026b4d47_720w.jpg","is_following":false,"is_org":false,"gender":1,"type":"people","id":"46002ffc26b33b0914a57ffac670a6ee"}
/// bound_topic_ids : [128,1522,26323,182424,700191]
/// title : "如何评价 UP 主 LexBurner 被判赔偿 B 站 2000 万，B 站将解封其账号及直播间？"
/// excerpt : ""
/// answer_count : 1103
/// created : 1639047159
/// url : "https://api.zhihu.com/questions/504894744"
/// comment_count : 122
/// is_following : false
/// follower_count : 2193
/// type : "question"
/// id : 504894744

class Question {
  Question({
    this.author,
    this.boundTopicIds,
    this.title,
    this.excerpt,
    this.detail,
    this.answerCount,
    this.created,
    this.url,
    this.commentCount,
    this.isFollowing,
    this.followerCount,
    this.type,
    this.id,
  });

  Question.fromJson(dynamic json) {
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    boundTopicIds = json['bound_topic_ids'] != null
        ? json['bound_topic_ids'].cast<int>()
        : [];
    title = json['title'];
    excerpt = json['excerpt'];
    detail = json['detail'];
    answerCount = json['answer_count'];
    created = json['created'];
    url = json['url'];
    commentCount = json['comment_count'];
    isFollowing = json['is_following'];
    followerCount = json['follower_count'];
    type = json['type'];
    if (json['id'] != null && json['id'] is String) {
      id = int.parse(json['id'] as String);
    } else {
      id = json['id'];
    }
  }

  Author? author;
  List<int>? boundTopicIds;
  String? title;
  String? excerpt;
  String? detail;
  int? answerCount;
  int? created;
  String? url;
  int? commentCount;
  bool? isFollowing;
  int? followerCount;
  String? type;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['bound_topic_ids'] = boundTopicIds;
    map['title'] = title;
    map['excerpt'] = excerpt;
    map['detail'] = detail;
    map['answer_count'] = answerCount;
    map['created'] = created;
    map['url'] = url;
    map['comment_count'] = commentCount;
    map['is_following'] = isFollowing;
    map['follower_count'] = followerCount;
    map['type'] = type;
    map['id'] = id;
    return map;
  }
}
