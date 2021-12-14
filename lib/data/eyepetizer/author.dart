/**
 *  {
    "id": 2165,
    "icon": "http://img.kaiyanapp.com/924ebc6780d59925c8a346a5dafc90bb.jpeg",
    "name": "开眼生活精选",
    "description": "匠心、健康、生活感悟",
    "link": "",
    "latestReleaseTime": 1536195614000,
    "videoNum": 112,
    "adTrack": null,
    "follow": {
    "itemType": "author",
    "itemId": 2165,
    "followed": false
    },
    "shield": {
    "itemType": "author",
    "itemId": 2165,
    "shielded": false
    },
    "approvedNotReadyVideoCount": 0,
    "ifPgc": true
    }
 */
class Author {
  int? id;
  String? icon;
  String? name;
  String? description;
  String? link;
  int? latestReleaseTime;
  int? videoNum;
  bool? adTrack;
  Follow? follow;

//  Shield shield;
  int? approvedNotReadyVideoCount;
  bool? ifPgc;

  Author.fromMap(Map<String, dynamic> map) {
    id = map["id"]??=0;
    icon = map["icon"];
    name = map["name"];
    description = map["description"];
    link = map["link"];
    latestReleaseTime = map["latestReleaseTime"];
    videoNum = map["videoNum"];
    adTrack = map["adTrack"];
    follow = Follow.fromMap(map["follow"]);
    approvedNotReadyVideoCount = map["approvedNotReadyVideoCount"];
    ifPgc = map["ifPgc"];
  }
}

/**
 *  {
    "itemType": "author",
    "itemId": 2165,
    "followed": false
    }
 */
class Follow {
  String? itemType;
  int? itemId;
  bool? followed;

  Follow.fromMap(Map<String, dynamic> map) {
    itemType = map["itemType"];
    itemId = map["itemId"];
    followed = map["followed"];
  }
}
