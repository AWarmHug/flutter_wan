class Cover {
  String? feed;
  String? detail;
  String? blurred;
  String? sharing;
  String? homepage;

  Cover.fromMap(Map<String, dynamic> map) {
    feed = map["feed"];
    detail = map["detail"];
    blurred = map["blurred"];
    sharing = map["sharing"];
    homepage = map["homepage"];
  }
}