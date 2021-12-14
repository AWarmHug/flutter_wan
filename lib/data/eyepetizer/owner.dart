class Owner {
  /**
   * uid : 300348215
   * nickname : 小光
   * avatar : http://thirdwx.qlogo.cn/mmopen/vi_32/WxLKJlXCibwqMrvskavocupP4Y3Ntp04CW7hR4Gj1uibQek74uONC3yRdATUPUC72Bt3D3E9piaaiaarxMINfCstVQ/132
   * userType : NORMAL
   * ifPgc : false
   * description : null
   * area : null
   * gender : null
   * registDate : 1484701385000
   * releaseDate : 1529226204000
   * cover : null
   * actionUrl : eyepetizer://pgc/detail/300348215/?title=%E5%B0%8F%E5%85%89&userType=NORMAL&tabIndex=0
   * followed : false
   * limitVideoOpen : true
   * library : BLOCK
   */

  int? uid;

  String? nickname;

  String? avatar;

  bool? ifPgc;

  String? description;

  String? area;

  String? gender;

  int? registDate;

  int? releaseDate;

  String? cover;

  String? actionUrl;

  Owner.fromMpa(Map<String,dynamic> map){
    uid=map["uid"];
    nickname=map["nickname"];
    avatar=map["avatar"];
    ifPgc=map["ifPgc"];
    description=map["description"];
    area=map["area"];
    gender=map["gender"];
    registDate=map["registDate"];
    releaseDate=map["releaseDate"];
    cover=map["cover"];
    actionUrl=map["actionUrl"];
  }


}
