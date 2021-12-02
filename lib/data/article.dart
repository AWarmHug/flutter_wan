import 'package:date_format/date_format.dart';

/// apkLink : ""
/// audit : 1
/// author : "yinshuai0324"
/// canEdit : false
/// chapterId : 539
/// chapterName : "未分类"
/// collect : false
/// courseId : 13
/// desc : "轻量级的Android吐司库，底层使用SnackBar实现，可以实现顶部弹出，底部弹出。\r\nUI可高度定制。支持自定义布局。可自定义显示时长。提供简洁的APi调用"
/// descMd : ""
/// envelopePic : "https://www.wanandroid.com/blogimgs/31a35017-491c-4191-94b2-1ce4be07c6b6.png"
/// fresh : true
/// host : ""
/// id : 19736
/// link : "https://www.wanandroid.com/blog/show/3066"
/// niceDate : "10小时前"
/// niceShareDate : "10小时前"
/// origin : ""
/// prefix : ""
/// projectLink : "https://github.com/yinshuai0324/ToastX"
/// publishTime : 1630854941000
/// realSuperChapterId : 293
/// selfVisible : 0
/// shareDate : 1630854941000
/// shareUser : ""
/// superChapterId : 294
/// superChapterName : "开源项目主Tab"
/// tags : [{"name":"项目","url":"/project/list/1?cid=539"}]
/// title : "ToastX"
/// type : 0
/// userId : -1
/// visible : 1
/// zan : 0

class Article {
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool collect = false;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List<Tags>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  Article(
      {this.apkLink,
      this.audit,
      this.author,
      this.canEdit,
      this.chapterId,
      this.chapterName,
      this.collect = false,
      this.courseId,
      this.desc,
      this.descMd,
      this.envelopePic,
      this.fresh,
      this.host,
      this.id,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.realSuperChapterId,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan});

  String get showAuthor {
    if (author != null && author!.isNotEmpty) {
      return author!;
    }
    if (shareUser != null && shareUser!.isNotEmpty) {
      return shareUser!;
    }
    return "";
  }

  String get showChapterName {
    String show = "";
    if (superChapterName != null && superChapterName!.isNotEmpty) {
      show = superChapterName!;
    }
    if (chapterName != null && chapterName!.isNotEmpty) {
      show = show + " · $chapterName";
    }
    return show;
  }

  String get showPublishTime {
    var now = DateTime.now();
    var publish = DateTime.fromMillisecondsSinceEpoch(
        publishTime ?? now.millisecondsSinceEpoch);
    if (now.millisecondsSinceEpoch - publish.millisecondsSinceEpoch >=
        24 * 60 * 60 * 1000) {
      //大于一天，显示日期
      return formatDate(publish, [mm, '-', dd, ' ', HH, ":", nn]);
    } else {
      //小于一天，显示多少小时前
      if (now.hour - publish.hour >= 1) {
        //大于一小时，显示多少小时前
        return "${now.hour - publish.hour}小时前";
      } else {
        //小于一小时，显示多少分钟前
        if (now.minute - publish.minute >= 5) {
          //大于5分钟，显示多少分钟前
          return "${now.minute - publish.minute}分钟前";
        } else {
          return "刚刚";
        }
      }
    }
  }

  Article.fromJson(dynamic json) {
    apkLink = json["apkLink"];
    audit = json["audit"];
    author = json["author"];
    canEdit = json["canEdit"];
    chapterId = json["chapterId"];
    chapterName = json["chapterName"];
    collect = json["collect"];
    courseId = json["courseId"];
    desc = json["desc"];
    descMd = json["descMd"];
    envelopePic = json["envelopePic"];
    fresh = json["fresh"];
    host = json["host"];
    id = json["id"];
    link = json["link"];
    niceDate = json["niceDate"];
    niceShareDate = json["niceShareDate"];
    origin = json["origin"];
    prefix = json["prefix"];
    projectLink = json["projectLink"];
    publishTime = json["publishTime"];
    realSuperChapterId = json["realSuperChapterId"];
    selfVisible = json["selfVisible"];
    shareDate = json["shareDate"];
    shareUser = json["shareUser"];
    superChapterId = json["superChapterId"];
    superChapterName = json["superChapterName"];
    if (json["tags"] != null) {
      tags = [];
      json["tags"].forEach((v) {
        tags?.add(Tags.fromJson(v));
      });
    }
    title = json["title"];
    type = json["type"];
    userId = json["userId"];
    visible = json["visible"];
    zan = json["zan"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["apkLink"] = apkLink;
    map["audit"] = audit;
    map["author"] = author;
    map["canEdit"] = canEdit;
    map["chapterId"] = chapterId;
    map["chapterName"] = chapterName;
    map["collect"] = collect;
    map["courseId"] = courseId;
    map["desc"] = desc;
    map["descMd"] = descMd;
    map["envelopePic"] = envelopePic;
    map["fresh"] = fresh;
    map["host"] = host;
    map["id"] = id;
    map["link"] = link;
    map["niceDate"] = niceDate;
    map["niceShareDate"] = niceShareDate;
    map["origin"] = origin;
    map["prefix"] = prefix;
    map["projectLink"] = projectLink;
    map["publishTime"] = publishTime;
    map["realSuperChapterId"] = realSuperChapterId;
    map["selfVisible"] = selfVisible;
    map["shareDate"] = shareDate;
    map["shareUser"] = shareUser;
    map["superChapterId"] = superChapterId;
    map["superChapterName"] = superChapterName;
    if (tags != null) {
      map["tags"] = tags?.map((v) => v.toJson()).toList();
    }
    map["title"] = title;
    map["type"] = type;
    map["userId"] = userId;
    map["visible"] = visible;
    map["zan"] = zan;
    return map;
  }
}

/// name : "项目"
/// url : "/project/list/1?cid=539"

class Tags {
  String? name;
  String? url;

  Tags({this.name, this.url});

  Tags.fromJson(dynamic json) {
    name = json["name"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["url"] = url;
    return map;
  }
}
