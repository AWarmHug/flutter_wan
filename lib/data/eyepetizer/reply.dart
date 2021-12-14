import 'user.dart';

/**
 * {
    "id": 1037357946134069200,
    "videoId": 125121,
    "videoTitle": "超萌！小蜘蛛卢卡斯的一人乐队",
    "message": "我看出来了，甭管什么，只要眼睛大，都可以统称为：“萌”",
    "likeCount": 23,
    "showConversationButton": false,
    "parentReplyId": 0,
    "rootReplyId": 1037357946134069200,
    "ifHotReply": true,
    "liked": false,
    "parentReply": null,
    "user": {
    "uid": 208897068,
    "nickname": "五猫不喫鱼",
    "avatar": "http://tva1.sinaimg.cn/crop.0.0.996.996.180/bb3176adjw8ez74bcgasaj20ro0ro410.jpg",
    "userType": "NORMAL",
    "ifPgc": false,
    "description": "憋土里，爬出来就不出去了。",
    "area": null,
    "gender": "male",
    "registDate": 1459292680000,
    "releaseDate": 1531644541000,
    "cover": "http://img.kaiyanapp.com/c7323f32be48224ec5a9cf6c825f9968.jpeg?imageMogr2/quality/60/format/jpg",
    "actionUrl": "eyepetizer://pgc/detail/208897068/?title=%E4%BA%94%E7%8C%AB%E4%B8%8D%E5%96%AB%E9%B1%BC&userType=NORMAL&tabIndex=0",
    "followed": false,
    "limitVideoOpen": false,
    "library": "BLOCK",
    "uploadStatus": "NORMAL",
    "bannedDate": null,
    "bannedDays": 0
    }
    }
 */
class Reply {
  int? id;
  int? videoId;
  String? videoTitle;
  String? message;
  int? likeCount;
  bool? showConversationButton;
  int? parentReplyId;
  int? rootReplyId;
  bool? ifHotReply;
  bool? liked;
  User? user;

  Reply.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    videoId = map["videoId"];
    videoTitle = map["videoTitle"];
    message = map["message"];
    likeCount = map["likeCount"];
    showConversationButton = map["showConversationButton"];
    parentReplyId = map["parentReplyId"];
    rootReplyId = map["rootReplyId"];
    ifHotReply = map["ifHotReply"];
    liked = map["liked"];
    user = User.fromMap(map["user"]);
  }
}
