/**
 * id : 14
 * name : 动画
 * actionUrl : eyepetizer://tag/14/?title=%E5%8A%A8%E7%94%BB
 * adTrack : null
 * desc : null
 * bgPicture : http://img.kaiyanapp.com/c4e5c0f76d21abbd23c9626af3c9f481.jpeg?imageMogr2/quality/100
 * headerImage : http://img.kaiyanapp.com/88da8548d31005032c37df4889d2104c.jpeg?imageMogr2/quality/100
 * tagRecType : IMPORTANT
 */
class Tag {
  int? id;
  String? name;
  String? actionUrl;
  int? adTrack;
  String? desc;
  String? bgPicture;
  String? headerImage;
  String? tagRecType;

  Tag.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    actionUrl = map["actionUrl"];
    adTrack = map["adTrack"];
    desc = map["desc"];
    bgPicture = map["bgPicture"];
    headerImage = map["headerImage"];
    tagRecType = map["tagRecType"];
  }
}
