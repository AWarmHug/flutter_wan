import 'cover.dart';

/**
 * {
    "id": 125619,
    "resourceType": "video",
    "uid": 0,
    "title": "回忆杀！5 分钟串烧 25 年金曲",
    "description": "说到过去 25 年的经典名曲你会想到什么歌？来自美国犹他州杨百翰大学的人声合唱团给出了答案。从「狮子王」里的「Can You Feel The Love Tonight」到席琳迪翁的「My Heart Will Go On」到后街男孩的「I Want It That Way」、再到「Let It Go」，你最爱哪一首呢？From BYU Vocal Point",
    "cover": {},
    "category": "音乐",
    "playUrl": "http://baobab.kaiyanapp.com/api/v1/playUrl?vid=125619&resourceType=video&editionType=default&source=aliyun",
    "duration": 307,
    "releaseTime": 1536368401000,
    "consumption": null,
    "collected": false,
    "actionUrl": "eyepetizer://ugcResourceDetail?id=125619&resourceType=video",
    "onlineStatus": "ONLINE",
    "count": 0
    }
 */
class SimpleVideo {
  int? id;
  String? resourceType;
  int? uid;
  String? title;
  String? description;
  Cover? cover;
  String? category;
  String? playUrl;
  int? duration;
  int? releaseTime;
  bool? collected;
  String? actionUrl;
  String? onlineStatus;

  SimpleVideo.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    resourceType = map["resourceType"];
    uid = map["uid"];
    title = map["title"];
    description = map["description"];
    cover = Cover.fromMap(map["cover"]);
    category = map["category"];
    playUrl = map["playUrl"];
    duration = map["duration"];
    releaseTime = map["releaseTime"];
    collected = map["collected"];
    actionUrl = map["actionUrl"];
    onlineStatus = map["onlineStatus"];
  }
}
