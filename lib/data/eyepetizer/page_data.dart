import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wan/widget/network_image.dart';
import 'consumption.dart';
import 'owner.dart';
import 'parent_reply.dart';
import 'tag.dart';
import 'author.dart';
import 'cover.dart';
import 'header.dart';
import 'base.dart';
import 'dart:convert';
import 'user.dart';
import 'simple_video.dart';
import 'reply.dart';

Widget buildPlaceHolder(double widget, double height) {
  return Container(
    child: CircularProgressIndicator(),
    alignment: Alignment.center,
    width: widget,
    height: height,
  );
}

Widget buildUserAvater(String avatar) {
  return ClipOval(
      child: CachedNetworkImage(
    imageUrl: avatar,
    placeholder: (context, url) => buildPlaceHolder(42.0, 42.0),
    errorWidget: (context, url, error) => Icon(Icons.error),
    width: 42.0,
    height: 42.0,
  ));
}

String timeFormate(int time) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
  return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
}

/**
 * itemList : []
 * count : 16
 * total : 0
 * nextPageUrl : http://baobab.kaiyanapp.com/api/v5/index/tab/allRec?page=1&isTag=true&adIndex=6
 * adExist : false
 */
class PageData extends BaseBean {
  late int count;

  int? total;

  String? nextPageUrl;

  bool? adExist;

  List<ContentItem>? itemList;

  operator +(PageData pageData) {
    count += pageData.count;
    total = pageData.total;
    nextPageUrl = pageData.nextPageUrl;
    adExist = pageData.adExist;
    itemList?.addAll(pageData.itemList!);
    return this;
  }

  PageData.fromJson(String json) {
    Map<String, dynamic> jsons = jsonDecode(json);
    count = jsons["count"];
    total = jsons["total"];
    nextPageUrl = jsons["nextPageUrl"];
    adExist = jsons["adExist"];
    List<dynamic> jsonList = jsons["itemList"];
    itemList = jsonList.map((jsonItem) {
      return ContentItem.fromMap(jsonItem);
    }).toList();
  }
}

/**
 * type : squareCardCollection
 * data : {}
 * tag : null
 * id : 0
 * adIndex : -1
 */
class ContentItem {
  static const String squareCardCollection = "squareCardCollection";
  static const String textCard = "textCard";
  static const String pictureFollowCard = "pictureFollowCard";
  static const String followCard = "followCard";
  static const String videoSmallCard = "videoSmallCard";
  static const String ugcPicture = "ugcPicture";
  static const String video = "video";
  static const String horizontalScrollCard = "horizontalScrollCard";
  static const String banner = "banner";
  static const String briefCard = "briefCard";
  static const String DynamicInfoCard = "DynamicInfoCard";
  static const String autoPlayVideoAd = "autoPlayVideoAd";
  static const String reply = "reply";

  String? type;

  BaseData? data;

  //上方[data]中的dataType;
  String? dataType;

  String? tag;

  int? id;

  int? adIndex;

  ContentItem.fromMap(Map<String, dynamic> map) {
    type = map["type"];
    tag = map["tag"];
    id = map["id"];
    adIndex = map["adIndex"];
    dataType = map["data"]["dataType"];
    if (dataType != null) {
      print(dataType);
      switch (dataType) {
        case BaseData.ItemCollection:
          data = ItemCollection.fromMap(map["data"]);
          break;
        case BaseData.FollowCard:
          data = FollowCard.fromMap(map["data"]);
          break;
        case BaseData.TextCard:
          data = TextCard.fromMap(map["data"]);
          break;
        case BaseData.UgcPictureBean:
          data = UgcPictureBean.fromMap(map["data"]);
          break;
        case BaseData.UgcVideoBean:
          data = UgcVideoBean.fromMap(map["data"]);
          break;
        case BaseData.VideoBeanForClient:
          data = VideoBeanForClient.fromMap(map["data"]);
          break;
        case BaseData.HorizontalScrollCard:
          data = HorizontalScrollCard.fromMap(map["data"]);
          break;
        case BaseData.Banner:
          data = Banner.fromMap(map["data"]);
          break;
        case BaseData.BriefCard:
          data = BriefCard.fromMap(map["data"]);
          break;
        case BaseData.DynamicReplyCard:
          data = DynamicReplyCard.fromMap(map["data"]);
          break;
        case BaseData.AutoPlayVideoAdDetail:
          data = AutoPlayVideoAdDetail.fromMap(map["data"]);
          break;
        case BaseData.ReplyBeanForClient:
          data = ReplyBeanForClient.fromMap(map["data"]);
          break;
        default:
          data = BaseData.fromMap(map["data"]);
          break;
      }
      data?.outType = type;
    }
  }

  Widget getWidget(BuildContext context) {
    return data!.getWidget(context);
  }

  @override
  String toString() {
    return 'ContentItem{type: $type, data: $data, dataType: $dataType, tag: $tag, id: $id, adIndex: $adIndex}';
  }
}

/**
 * dataType : FollowCard
 * header : {}
 * content : {}
 * adTrack : null
 */
class BaseData {
  static const String ItemCollection = "ItemCollection";
  static const String FollowCard = "FollowCard";
  static const String TextCard = "TextCard";
  static const String UgcPictureBean = "UgcPictureBean";
  static const String UgcVideoBean = "UgcVideoBean";
  static const String VideoBeanForClient = "VideoBeanForClient";
  static const String HorizontalScrollCard = "HorizontalScrollCard";
  static const String Banner = "Banner";
  static const String BriefCard = "BriefCard";
  static const String DynamicReplyCard = "DynamicReplyCard";
  static const String AutoPlayVideoAdDetail = "AutoPlayVideoAdDetail";
  static const String ReplyBeanForClient = "ReplyBeanForClient";

  ///外层的type
  String? outType;

  String? dataType;

  BaseData.fromMap(Map<String, dynamic> map) {
    dataType = map["dataType"];
  }

  Widget getWidget(BuildContext context) {
    return Text("未知类型,抱歉");
  }
}

/**
 * header : {}
 * itemList : []
 * count : 5
 */
class ItemCollection extends BaseData {
  ItemCollectionHeader? header;
  int? count;
  List<ContentItem> itemList = [];

  ItemCollection.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    header = ItemCollectionHeader.fromJson(map["header"]);
    count = map["count"];
    List<dynamic> itemListJsons = map["itemList"];
    itemList = itemListJsons.map((itemListJson) {
      return ContentItem.fromMap(itemListJson);
    }).toList();
  }

  @override
  Widget getWidget(BuildContext context) {
    //TODO 高度问题
    return Container(
      height: 270.0,
      alignment: Alignment.centerLeft,
      child: PageView.builder(
        itemBuilder: (context, position) {
          return itemList[position].getWidget(context);
        },
        itemCount: itemList.length,
      ),
    );
  }
}

/**
 * dataType : FollowCard
 * header : {}
 * content : {}
 */
class FollowCard extends BaseData {
  FollowCardHeader? header;
  ContentItem? content;

  FollowCard.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    header = FollowCardHeader.fromJson(map["header"]);
    content = ContentItem.fromMap(map["content"]);
  }

  @override
  Widget getWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        content!.getWidget(context),
      ],
    );
  }
}

/**
 * id : 0
 * type : header5
 * text : 社区精选
 * subTitle : null
 * actionUrl : null
 * adTrack : null
 * follow : null
 */
class TextCard extends BaseData {
  int? id;
  String? type;
  String? text;
  String? subTitle;
  String? actionUrl;

//  Follow follow;
  TextCard.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    type = map["type"];
    text = map["text"];
    subTitle = map["subTitle"];
    actionUrl = map["actionUrl"];
  }

  Widget getWidget(BuildContext context) {
    Widget textChild;
    //2表示可以点击,5表示不可以
    switch (type) {
      case "footer2":
        List<Widget> footers = [];
        footers.add(Text(
          text!,
          style: TextStyle(
              fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
        ));
        if (actionUrl != null) {
          footers.add(GestureDetector(
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 14.0,
            ),
            onTap: () {},
          ));
        }

        textChild = Row(
          children: footers,
          mainAxisAlignment: MainAxisAlignment.end,
        );
        break;
      case "header5":
        List<Widget> headers = [];

        headers.add(Text(
          text!,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ));

        if (actionUrl != null) {
          headers.add(Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 18.0,
          ));
        }

        textChild = Row(children: headers);
        break;
      default:
        textChild = Text(
          text!,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        );
        break;
    }

    return Padding(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
      child: textChild,
    );
  }
}

class UgcBean extends BaseData {
  int? id;
  String? title;
  String? description;
  String? library;

  Consumption? consumption;
  String? resourceType;
  int? uid;
  int? createTime;
  int? updateTime;
  bool? collected;

  Owner? owner;
  int? selectedTime;
  String? checkStatus;
  String? area;
  Cover? cover;
  int? releaseTime;

//  Object transId;

  List<Tag> tags = [];

  UgcBean.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    library = map["library"];
    resourceType = map["resourceType"];
    uid = map["uid"];
    createTime = map["createTime"];
    updateTime = map["updateTime"];
    collected = map["collected"];
    selectedTime = map["selectedTime"];
    checkStatus = map["checkStatus"];
    releaseTime = map["releaseTime"];
    consumption = Consumption.fromMap(map["consumption"]);
    area = map["area"];
    cover = Cover.fromMap(map["cover"]);
    owner = Owner.fromMpa(map["owner"]);
    List<dynamic> dyTags = map["tags"];
    if (dyTags != null) {
      tags = dyTags.map((dyTag) {
        return Tag.fromMap(dyTag);
      }).toList();
    }
  }

  @override
  Widget getWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              buildUserAvater(owner!.avatar!),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12.0),
                  height: 42.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        owner!.nickname!,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "在${area != null || area!.isNotEmpty ? area : "未知位置"}发布",
                          style: TextStyle(color: Colors.grey, fontSize: 12.0))
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(description!,
                style: TextStyle(color: Colors.grey, fontSize: 14.0)),
          ),
          getBody(context),
          Row(
            children: <Widget>[
              Expanded(child: Text(timeFormate(updateTime!))),
              Icon(
                Icons.ten_k,
                size: 16.0,
              ),
              Text("${consumption!.collectionCount}"),
              buildShareIconButton()
            ],
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Text("请添加body");
  }
}

/**
 * id : 1012
 * title :
 * description : 卢卡库进球瞬间
 * library : DAILY
 * tags : []
 * consumption : {"collectionCount":6,"shareCount":0,"replyCount":1}
 * resourceType : ugc_video
 * uid : 14873011
 * createTime : 1529350684000
 * updateTime : 1529374832000
 * collected : false
 * owner : {}
 * selectedTime : 1529374832000
 * checkStatus : CHECKED
 * playUrl : http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1012&resourceType=ugc_video&editionType=default&source=aliyun
 * cover : {}
 * status : ONLINE
 * releaseTime : 1529350684000
 * duration : 15
 * transId : null
 * type : COMMON
 */
class UgcVideoBean extends UgcBean {
  String? playUrl;
  int? duration;
  String? type;
  String? status;

  UgcVideoBean.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    playUrl = map["playUrl"];
    duration = map["duration"];
    type = map["type"];
    status = map["status"];
  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: buildVideo(),
        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context){
//            return VideoDetailPage();
//          }));
        },
      ),
    );
  }

  Widget buildVideo() {
    return Column(
      children: <Widget>[Text("这是视频"), buildImage()],
    );
  }

  Widget buildImage() {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: cover!.detail!,
        placeholder: (context, url) => buildPlaceHolder(double.infinity, 200.0),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        fit: BoxFit.cover,
        height: 200.0,
        width: double.infinity,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
  }
}

/**
 * id : 1299
 * title :
 * description : 我注意过，即使是那些声称“一切都是命中注定的，而且我们无力改变”的人，在过马路前都会左右看。by 史蒂芬·霍金
 * library : DAILY
 * tags : []
 * consumption : {}
 * resourceType : ugc_picture
 * uid : 300348215
 * createTime : 1529226136000
 * updateTime : 1529238345000
 * collected : false
 * owner : {}
 * selectedTime : 1529237690000
 * checkStatus : CHECKED
 * url : http://img.kaiyanapp.com/57226e7d01f3110444dd26a56557c32b.png?imageMogr2/quality/100!/format/jpg
 * cover : {}
 * status : 1
 * releaseTime : 1529226136000
 */
class UgcPictureBean extends UgcBean {
  String? url;
  List<String> urls = [];
  int? status;

  UgcPictureBean.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    url = map["url"];
    List<dynamic> dyUrls = map["urls"];
    urls = dyUrls.map((url) {
      return url.toString();
    }).toList();
    status = map["status"];
  }

  @override
  Widget getBody(BuildContext context) {
    double width = urls.length == 1
        ? MediaQuery.of(context).size.width - 20.0
        : MediaQuery.of(context).size.width / (urls.length > 4 ? 3 : 2) - 20.0;

    double height = (urls.length == 1 || urls.length == 2) ? 200.0 : 100.0;

    List<Widget> images = urls.map((url) {
      return CachedNetworkImage(
        imageUrl: cover!.detail!,
        placeholder: (context, url) => buildPlaceHolder(width, height),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }).toList();
    return Container(
      child: ClipRRect(
        child: Wrap(
          children: images,
          runSpacing: 4.0,
          spacing: 4.0,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
    );
  }
}

/**
 * id : 1130
 * title : 世界本该如此：One Day
 * description : 生活中，不如意事常八九，但仔细想想，总有那么些人愿意倾听你的烦恼，并给予必要的帮助。对于那些帮助你的人，最好的回馈方式大概是让这种爱传递下去。今日奉上古早的一镜到底，感恩节，祝每个人都快乐。From geeze
 * library : DAILY
 * tags : []
 * consumption : {}
 * resourceType : video
 * slogan : null
 * provider : {}
 * category : 音乐
 * author : {}
 * cover : {}
 * playUrl : http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=default&source=aliyun
 * thumbPlayUrl : null
 * duration : 287
 * webUrl : {}
 * releaseTime : 1448467200000
 * playInfo : []
 * campaign : null
 * waterMarks : null
 * adTrack : null
 * type : NORMAL
 * titlePgc : null
 * descriptionPgc : null
 * remark : null
 * ifLimitVideo : false
 * searchWeight : 0
 * idx : 0
 * shareAdTrack : null
 * favoriteAdTrack : null
 * webAdTrack : null
 * date : 1448467200000
 * promotion : null
 * label : null
 * labelList : []
 * descriptionEditor : 生活中，不如意事常八九，但仔细想想，总有那么些人愿意倾听你的烦恼，并给予必要的帮助。对于那些帮助你的人，最好的回馈方式大概是让这种爱传递下去。今日奉上古早的一镜到底，感恩节，祝每个人都快乐。From geeze
 * collected : false
 * played : false
 * subtitles : []
 * lastViewTime : null
 * playlists : null
 * src : 7
 */
class VideoBeanForClient extends BaseData {
  int? id;
  String? title;
  String? description;
  String? library;

  Consumption? consumption;
  String? resourceType;

//    Provider provider;
  String? category;

  Author? author;
  Cover? cover;
  String? playUrl;
  Object? thumbPlayUrl;
  int? duration;

  String getDuration() {
//    int m = (duration / 60) as int;
//    int s = duration % 60;

    return duration.toString();
  }

//    WebUrl webUrl;
  int? releaseTime;

//  Object campaign;
//  Object waterMarks;
  String? type;

//  Object titlePgc;
//  Object descriptionPgc;
//  Object remark;
  bool? ifLimitVideo;
  int? searchWeight;
  int? idx;
  int? shareAdTrack;
  int? favoriteAdTrack;
  int? webAdTrack;
  int? date;

//  Object promotion;

//    Label label;
  String? descriptionEditor;
  bool? collected;
  bool? played;

//  Object lastViewTime;
//  Object playlists;
  int? src;

  List<Tag> tags = [];

//    List<PlayInfo> playInfo;
//    List<Label> labelList;
//    List<?> subtitles;

  VideoBeanForClient.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    library = map["library"];
    resourceType = map["resourceType"];
    category = map["category"];
    playUrl = map["playUrl"];
    thumbPlayUrl = map["thumbPlayUrl"];
    collected = map["collected"];
    duration = map["duration"];
    releaseTime = map["releaseTime"];
    type = map["type"];
    ifLimitVideo = map["ifLimitVideo"];
    searchWeight = map["searchWeight"];
    idx = map["idx"];
    shareAdTrack = map["shareAdTrack"];
    favoriteAdTrack = map["favoriteAdTrack"];
    webAdTrack = map["webAdTrack"];
    date = map["date"];
    descriptionEditor = map["descriptionEditor"];
    collected = map["collected"];
    played = map["played"];
    src = map["src"];
    cover = Cover.fromMap(map["cover"]);
    author = Author.fromMap(map["author"]);
    consumption = Consumption.fromMap(map["consumption"]);
    List<dynamic> dyTags = map["tags"];
    tags = dyTags.map((dyTag) {
      return Tag.fromMap(dyTag);
    }).toList();
  }

  @override
  Widget getWidget(BuildContext context) {
    Widget video = GestureDetector(
      child: outType == ContentItem.videoSmallCard
          ? buildVideoSmallCard()
          : buildVideo(),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //   return VideoDetailPage(this);
        // }));
      },
    );

    if (outType == ContentItem.videoSmallCard) {
      return Container(
        height: 100.0,
        margin: EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
        child: video,
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
        child: video,
      );
    }
  }

  Widget buildVideo() {
    return Column(
      children: <Widget>[
        ClipRRect(
          child: Container(
            child: CachedNetworkImage(
              imageUrl: cover!.detail!,
              placeholder: (context, url) =>
                  buildPlaceHolder(double.infinity, 200.0),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        Container(
          height: 42.0,
          margin: EdgeInsets.only(top: 8.0),
          alignment: Alignment.bottomLeft,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print("结婚后");
                },
                child: buildUserAvater(author!.icon!),
              ),
              Expanded(
                child: Container(
                  height: 42.0,
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildTitle(),
                      Text(
                        author!.name!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              buildShareIconButton()
            ],
          ),
        )
      ],
    );
  }

  Widget buildVideoSmallCard() {
    return Row(
      children: <Widget>[
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: cover!.detail!,
            placeholder: (context, url) => buildPlaceHolder(160.0, 100.0),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Expanded(
                  child: buildTitle(),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        author!.name!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildShareIconButton()
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Text buildTitle() {
    return Text(
      title!,
      style: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }
}

Widget buildShareIconButton() {
  return IconButton(
      icon: Icon(
        Icons.share,
        color: Colors.grey,
        size: 20.0,
      ),
      onPressed: null);
}

class HorizontalScrollCard extends BaseData {
  List<ContentItem> itemList = [];

  HorizontalScrollCard.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    List<dynamic> itemJsons = map["itemList"];
    itemList = itemJsons.map((itemJson) {
      return ContentItem.fromMap(itemJson);
    }).toList();
  }

  @override
  Widget getWidget(BuildContext context) {
    //TODO 高度问题
//    double height;
//    if(outType==ContentItem.banner2){
//      height=200.0;
//    }
//
//    if(outType==ContentItem.followCard){
//      height=200.0;
//    }

    return Container(
      height: 230.0,
      child: PageView.builder(
        itemBuilder: (context, position) {
          return itemList[position].getWidget(context);
        },
        itemCount: itemList.length,
      ),
    );
  }
}

class Banner extends BaseData {
  int? id;
  String? title;
  String? description;
  String? image;
  String? actionUrl;
  bool? shade;

  Banner.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    image = map["image"];
    actionUrl = map["actionUrl"];
    shade = map["shade"];
  }

  @override
  Widget getWidget(BuildContext context) {
    return AppNetworkImage(
      imageUrl: image!,
      fit: BoxFit.cover,
    );
  }
}

/**
 * {
    "dataType": "BriefCard",
    "id": 6,
    "icon": "http://img.kaiyanapp.com/75bc791c5f6cc239d6056e0a52d077fd.jpeg?imageMogr2/quality/60/format/jpg",
    "iconType": "square",
    "title": "#旅行",
    "subTitle": null,
    "description": "发现世界的奇妙和辽阔",
    "actionUrl": "eyepetizer://category/6/?title=%E6%97%85%E8%A1%8C",
    "adTrack": null,
    "follow": {},
    "ifPgc": false
    }
 */
class BriefCard extends BaseData {
  int? id;
  String? icon;
  String? iconType;
  String? title;
  String? subTitle;
  String? description;
  String? actionUrl;
  bool? ifPgc;

  BriefCard.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    icon = map["icon"];
    iconType = map["iconType"];
    title = map["title"];
    subTitle = map["subTitle"];
    description = map["description"];
    actionUrl = map["actionUrl"];
    ifPgc = map["ifPgc"];
  }

  @override
  Widget getWidget(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: AppNetworkImage(
              imageUrl: icon!,
              width: 42.0,
              height: 42.0,
            ),
          ),
          Container(
            height: 42.0,
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  title!,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
        ],
      ),
    );
  }
}

/**
 * {
    "dataType": "DynamicReplyCard",
    "dynamicType": "reply",
    "text": "评论:",
    "actionUrl": "eyepetizer://replies/video?videoId=125508&top=1037584459647418368&videoTitle=%E8%B7%AF%E8%99%8E%E6%8B%8D%E4%BA%86%E6%94%AF%E5%B9%BF%E5%91%8A%EF%BC%8C%20%E6%8A%8A%E5%85%A8%E5%9F%8E%E5%8F%B8%E6%9C%BA%E9%83%BD%E5%BE%97%E7%BD%AA%E4%BA%86",
    "user": {},
    "mergeNickName": null,
    "mergeSubTitle": null,
    "merge": false,
    "createDate": 1536214387000,
    "simpleVideo": {},
    "reply": {}
    }
 */
class DynamicReplyCard extends BaseData {
  String? dynamicType;
  String? text;
  String? actionUrl;
  User? user;
  String? mergeNickName;
  String? mergeSubTitle;
  bool? merge;
  int? createDate;
  SimpleVideo? simpleVideo;
  Reply? reply;

  DynamicReplyCard.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    dynamicType = map["dynamicType"];
    text = map["text"];
    actionUrl = map["actionUrl"];
    user = User.fromMap(map["user"]);
    mergeNickName = map["mergeNickName"];
    mergeSubTitle = map["mergeSubTitle"];
    merge = map["merge"];
    createDate = map["createDate"];
    simpleVideo = SimpleVideo.fromMap(map["simpleVideo"]);
    reply = Reply.fromMap(map["reply"]);
  }

  @override
  Widget getWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildAvatar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildHeaderText(),
                  Text(
                    reply!.message!,
                    style: TextStyle(color: Colors.black87, fontSize: 14.0),
                  ),
                  buildBodyContent(),
                  buildTail()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return buildUserAvater(user!.avatar!);
  }

  Widget buildHeaderText() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user!.nickname!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                text!,
                style: TextStyle(fontSize: 13.0, color: Colors.grey),
              )
            ],
          ),
        ),
        Container(
          child: Text("热评",
              style: TextStyle(fontSize: 12.0, color: Colors.indigo)),
          padding:
              EdgeInsets.only(left: 2.0, top: 1.0, right: 2.0, bottom: 1.0),
        ),
        Icon(
          Icons.chevron_right,
          color: Colors.grey,
          size: 20.0,
        )
      ],
    );
  }

  Widget buildBodyContent() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: AppNetworkImage(
                  imageUrl: simpleVideo!.cover!.detail!,
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.only(right: 8.0),
              height: 88.0,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  simpleVideo!.title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "#" + simpleVideo!.category!,
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
        ],
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
    );
  }

  Widget buildTail() {
    return Row(
      children: <Widget>[Text("回复")],
    );
  }
}

class AutoPlayVideoAdDetail extends BaseData {
  AutoPlayVideoAdDetail.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  @override
  Widget getWidget(BuildContext context) {
    // TODO: implement getWidget
    return Container(
      child: Text(
        "这是广告,暂时不显示",
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

//{
//"dataType": "ReplyBeanForClient",
//"id": 1037217596635611100,
//"videoId": 120654,
//"videoTitle": "爱情诚可贵，友谊价更高",
//"parentReplyId": 0,
//"rootReplyId": 1037217596635611100,
//"sequence": 12,
//"message": "值得深思",
//"replyStatus": "PUBLISHED",
//"createTime": 1536126920000,
//"user": {},
//"likeCount": 0,
//"liked": false,
//"hot": false,
//"userType": null,
//"type": "video",
//"actionUrl": null,
//"imageUrl": null,
//"ugcVideoId": null,
//"parentReply": null,
//"showParentReply": true,
//"showConversationButton": false,
//"ugcVideoUrl": null,
//"cover": null,
//"userBlocked": false,
//"sid": "1037217596635611136"
//}
class ReplyBeanForClient extends BaseData {
  int? id;
  int? videoId;
  String? videoTitle;
  int? parentReplyId;
  int? rootReplyId;
  String? message;
  int? createTime;
  User? user;
  int? likeCount;
  bool? hot;
  String? type;
  String? actionUrl;
  String? imageUrl;
  ParentReply? parentReply;

  ReplyBeanForClient.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    id = map["id"];
    videoId = map["videoId"];
    videoTitle = map["videoTitle"];
    parentReplyId = map["parentReplyId"];
    rootReplyId = map["rootReplyId"];
    message = map["message"];
    createTime = map["createTime"];
    user = User.fromMap(map["user"]);
    likeCount = map["likeCount"];
    hot = map["hot"];
    type = map["type"];
    actionUrl = map["actionUrl"];
    imageUrl = map["imageUrl"];
    dynamic dyParentReply = map["parentReply"];
    if (dyParentReply != null) {
      parentReply = ParentReply.fromMap(dyParentReply);
    }
  }

  @override
  Widget getWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildUserAvater(user!.avatar!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          user!.nickname!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_sharp,
                            size: 20.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              likeCount.toString(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      message!,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Offstage(
                        child: Text(
                          "查看对话",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        offstage: parentReply == null,
                      ),
                      Expanded(
                          child: Text(
                        timeFormate(createTime!),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
