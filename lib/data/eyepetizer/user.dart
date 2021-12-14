/**
 *{
    "uid": 300858179,
    "nickname": "何者.",
    "avatar": "http://img.kaiyanapp.com/427e34c74be30a903504d6fb3e879c1e.jpeg?imageMogr2/quality/60/format/jpg",
    "userType": "NORMAL",
    "ifPgc": false,
    "description": null,
    "area": null,
    "gender": "male",
    "registDate": 1499742435000,
    "releaseDate": null,
    "cover": null,
    "actionUrl": "eyepetizer://pgc/detail/300858179/?title=%E4%BD%95%E8%80%85.&userType=NORMAL&tabIndex=0",
    "followed": false,
    "limitVideoOpen": true,
    "library": "BLOCK",
    "uploadStatus": "NORMAL",
    "bannedDate": null,
    "bannedDays": 0
    }
 */
class User{
  int? uid;
  String? nickname;
  String? avatar;
  String? userType;
  bool? ifPgc;
  String? description;
  String? area;
  String? gender;
  int? registDate;
  String? cover;
  String? actionUrl;

  User.fromMap(Map<String,dynamic> map){
    uid=map["uid"];
    nickname=map["nickname"];
    avatar=map["avatar"];
    userType=map["userType"];
    ifPgc=map["ifPgc"];
    description=map["description"];
    area=map["area"];
    gender=map["gender"];
    registDate=map["registDate"];
    cover=map["cover"];
    actionUrl=map["actionUrl"];
  }


}
