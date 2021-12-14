import 'package:flutter/material.dart';

/**
 * id : 5
 * title : 开眼今日编辑精选
 * font : bigBold
 * subTitle : MONDAY, JUNE 18
 * subTitleFont : lobster
 * textAlign : left
 * cover : null
 * label : null
 * actionUrl : eyepetizer://feed?tabIndex=2
 * labelList : null
 */
class BaseHeader {
  int? id;
  String? title;
  String? font;
  String? subTitle;
  String? subTitleFont;
  String? textAlign;

//    Object cover;
//    Label label;
  String? actionUrl;

  //    List<Label> labelList;

  BaseHeader.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    font = map["font"];
    subTitle = map["subTitle"];
    subTitleFont = map["subTitleFont"];
    textAlign = map["textAlign"];
    actionUrl = map["actionUrl"];
  }

  Widget getWidget() {
    CrossAxisAlignment crossAxisAlignment;
    switch(textAlign){
      case "center":
      crossAxisAlignment=CrossAxisAlignment.center;
      break;
      case "right":
        crossAxisAlignment=CrossAxisAlignment.end;
        break;
      default:
        crossAxisAlignment=CrossAxisAlignment.start;
        break;
    }


    List<Widget> texts = [];
    if (subTitle != null) {
      texts.add(Text(
        subTitle!,
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),
      ));
    }

    if (title != null) {
      texts.add(Text(
        title!,
        style: TextStyle(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
      ));
    }

    return Builder(
      builder: (context) {
        return FlatButton(
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: <Widget>[
              Text(
                title!,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          onPressed: () {
            var route = MaterialPageRoute(builder: (BuildContext context) {
              return Center(child: Text("哈哈哈"));
            });
            Navigator.of(context).push(route);
          },
        );
      }
    );
  }
}

/**
 * font : null
 * subTitle : null
 * subTitleFont : null
 * cover : null
 * label : null
 * labelList : null
 * icon : http://img.kaiyanapp.com/22192a40de238fe853b992ed57f1f098.jpeg
 * iconType : round
 * description : 科幻外衣下的爱情内核
 * time : 1528712855000
 * showHateVideo : false
 */
class FollowCardHeader extends BaseHeader {
  String? icon;

  String? iconType;

  String? description;

  int? time;

  bool? showHateVideo;

  FollowCardHeader.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    icon = map["icon"];
    iconType = map["iconType"];
    description = map["description"];
    time = map["time"];
    showHateVideo = map["showHateVideo"];
  }
}

class ItemCollectionHeader extends BaseHeader {
  ItemCollectionHeader.fromJson(Map<String, dynamic> map) : super.fromJson(map);
}

/**
 * {
    "icon": "http://img.kaiyanapp.com/3774b50ee962019b7314f4a3c5434328.png?imageMogr2/quality/60/format/jpg",
    "description": "1664法蓝晚宴，你准备好赴约了吗？"
    }
 */
class BannerHeader extends BaseHeader {
  String? icon;

  String? description;

  BannerHeader.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    icon = map["icon"];
    description = map["description"];
  }
}
