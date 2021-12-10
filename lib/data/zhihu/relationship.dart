/// voting : 0
/// is_thanked : false
/// is_nothelp : false
/// upvoted_followee_ids : []

class Relationship {
  Relationship({
    this.voting,
    this.isThanked,
    this.isNothelp,
    this.upvotedFolloweeIds,});

  Relationship.fromJson(dynamic json) {
    voting = json['voting'];
    isThanked = json['is_thanked'];
    isNothelp = json['is_nothelp'];
    if (json['upvoted_followee_ids'] != null) {
      upvotedFolloweeIds = [];
      json['upvoted_followee_ids'].forEach((v) {
        upvotedFolloweeIds?.add(v);
      });
    }
  }
  int? voting;
  bool? isThanked;
  bool? isNothelp;
  List<dynamic>? upvotedFolloweeIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['voting'] = voting;
    map['is_thanked'] = isThanked;
    map['is_nothelp'] = isNothelp;
    if (upvotedFolloweeIds != null) {
      map['upvoted_followee_ids'] = upvotedFolloweeIds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}