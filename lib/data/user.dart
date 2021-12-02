/// coinInfo : {"coinCount":36662,"level":367,"nickname":"","rank":"3","userId":2,"username":"x**oyang"}
/// userInfo : {"admin":false,"chapterTops":["a"],"coinCount":36662,"collectIds":["a"],"email":"623565791@qq.com","icon":"","id":2,"nickname":"鸿洋","password":"","publicName":"鸿洋","token":"","type":0,"username":"xiaoyang"}

class User {
  CoinInfo? coinInfo;
  UserInfo? userInfo;

  User({
      this.coinInfo, 
      this.userInfo});

  User.fromJson(dynamic json) {
    coinInfo = json["coinInfo"] != null ? CoinInfo.fromJson(json["coinInfo"]) : null;
    userInfo = json["userInfo"] != null ? UserInfo.fromJson(json["userInfo"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (coinInfo != null) {
      map["coinInfo"] = coinInfo?.toJson();
    }
    if (userInfo != null) {
      map["userInfo"] = userInfo?.toJson();
    }
    return map;
  }

}

/// admin : false
/// chapterTops : ["a"]
/// coinCount : 36662
/// collectIds : ["a"]
/// email : "623565791@qq.com"
/// icon : ""
/// id : 2
/// nickname : "鸿洋"
/// password : ""
/// publicName : "鸿洋"
/// token : ""
/// type : 0
/// username : "xiaoyang"

class UserInfo {
  bool? admin;
  List<String>? chapterTops;
  int? coinCount;
  List<String>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  UserInfo({
      this.admin, 
      this.chapterTops, 
      this.coinCount, 
      this.collectIds, 
      this.email, 
      this.icon, 
      this.id, 
      this.nickname, 
      this.password, 
      this.publicName, 
      this.token, 
      this.type, 
      this.username});

  UserInfo.fromJson(dynamic json) {
    admin = json["admin"];
    chapterTops = json["chapterTops"] != null ? json["chapterTops"].cast<String>() : [];
    coinCount = json["coinCount"];
    collectIds = json["collectIds"] != null ? json["collectIds"].cast<String>() : [];
    email = json["email"];
    icon = json["icon"];
    id = json["id"];
    nickname = json["nickname"];
    password = json["password"];
    publicName = json["publicName"];
    token = json["token"];
    type = json["type"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["admin"] = admin;
    map["chapterTops"] = chapterTops;
    map["coinCount"] = coinCount;
    map["collectIds"] = collectIds;
    map["email"] = email;
    map["icon"] = icon;
    map["id"] = id;
    map["nickname"] = nickname;
    map["password"] = password;
    map["publicName"] = publicName;
    map["token"] = token;
    map["type"] = type;
    map["username"] = username;
    return map;
  }

}

/// coinCount : 36662
/// level : 367
/// nickname : ""
/// rank : "3"
/// userId : 2
/// username : "x**oyang"

class CoinInfo {
  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  CoinInfo({
      this.coinCount, 
      this.level, 
      this.nickname, 
      this.rank, 
      this.userId, 
      this.username});

  CoinInfo.fromJson(dynamic json) {
    coinCount = json["coinCount"];
    level = json["level"];
    nickname = json["nickname"];
    rank = json["rank"];
    userId = json["userId"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coinCount"] = coinCount;
    map["level"] = level;
    map["nickname"] = nickname;
    map["rank"] = rank;
    map["userId"] = userId;
    map["username"] = username;
    return map;
  }

}



