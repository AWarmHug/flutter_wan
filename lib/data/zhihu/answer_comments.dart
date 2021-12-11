import 'package:flutter_wan/data/response_wan.dart';

import 'answer_comment.dart';
import 'paging.dart';

/// featured_counts : 10
/// common_counts : 731
/// collapsed_counts : 15
/// reviewing_counts : 0
/// top_counts : 0
/// comment_status : {"can_comment":true,"can_reply":true,"toast":"评论千万条，友善第一条"}
/// paging : {"is_end":false,"is_start":true,"next":"https://www.zhihu.com/api/v4/answers/2260946749/comments?include=data%5B%2A%5D.author&limit=10&offset=10&order=normal&status=open","previous":"https://www.zhihu.com/api/v4/answers/2260946749/comments?include=data%5B%2A%5D.author&limit=10&offset=0&order=normal&status=open","totals":731}
/// data : []

class AnswerComments extends ResponseWan<List<AnswerComment>> {
  AnswerComments.fromJson(dynamic json) : super.fromJson(json) {
    featuredCounts = json['featured_counts'];
    commonCounts = json['common_counts'];
    collapsedCounts = json['collapsed_counts'];
    reviewingCounts = json['reviewing_counts'];
    topCounts = json['top_counts'];
    commentStatus = json['comment_status'] != null
        ? Comment_status.fromJson(json['comment_status'])
        : null;
    // paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    // if (json['data'] != null) {
    //   data = [];
    //   json['data'].forEach((v) {
    //     data?.add(AnswerComment.fromJson(v));
    //   });
    // }
  }

  int? featuredCounts;
  int? commonCounts;
  int? collapsedCounts;
  int? reviewingCounts;
  int? topCounts;
  Comment_status? commentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['featured_counts'] = featuredCounts;
    map['common_counts'] = commonCounts;
    map['collapsed_counts'] = collapsedCounts;
    map['reviewing_counts'] = reviewingCounts;
    map['top_counts'] = topCounts;
    if (commentStatus != null) {
      map['comment_status'] = commentStatus?.toJson();
    }
    if (paging != null) {
      map['paging'] = paging?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Comment_status {
  Comment_status({
    this.canComment,
    this.canReply,
    this.toast,
  });

  Comment_status.fromJson(dynamic json) {
    canComment = json['can_comment'];
    canReply = json['can_reply'];
    toast = json['toast'];
  }

  bool? canComment;
  bool? canReply;
  String? toast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_comment'] = canComment;
    map['can_reply'] = canReply;
    map['toast'] = toast;
    return map;
  }
}
