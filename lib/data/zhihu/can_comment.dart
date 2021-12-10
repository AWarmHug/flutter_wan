/// status : true
/// reason : ""

class Can_comment {
  Can_comment({
    this.status,
    this.reason,});

  Can_comment.fromJson(dynamic json) {
    status = json['status'];
    reason = json['reason'];
  }
  bool? status;
  String? reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['reason'] = reason;
    return map;
  }

}