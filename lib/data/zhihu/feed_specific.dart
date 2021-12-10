/// answer_count : 561

class FeedSpecific {
  FeedSpecific({
      this.answerCount,});

  FeedSpecific.fromJson(dynamic json) {
    answerCount = json['answer_count'];
  }
  int? answerCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer_count'] = answerCount;
    return map;
  }

}