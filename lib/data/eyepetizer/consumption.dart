class Consumption {
  /**
   * collectionCount : 24
   * shareCount : 0
   * replyCount : 0
   */

  int? collectionCount;
  int? shareCount;
  int? replyCount;

  Consumption.fromMap(Map<String, dynamic> map) {
    collectionCount = map["collectionCount"];
    shareCount = map["shareCount"];
    replyCount = map["replyCount"];
  }
}
