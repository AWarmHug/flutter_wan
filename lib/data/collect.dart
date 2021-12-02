

class Collect {
  Collect({
      this.author, 
      this.chapterId, 
      this.chapterName, 
      this.courseId, 
      this.desc, 
      this.envelopePic, 
      this.id, 
      this.link, 
      this.niceDate, 
      this.origin, 
      this.originId, 
      this.publishTime, 
      this.title, 
      this.userId, 
      this.visible, 
      this.zan,});

  Collect.fromJson(dynamic json) {
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    origin = json['origin'];
    originId = json['originId'];
    publishTime = json['publishTime'];
    title = json['title'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }
  String? author;
  int? chapterId;
  String? chapterName;
  int? courseId;
  String? desc;
  String? envelopePic;
  int? id;
  String? link;
  String? niceDate;
  String? origin;
  int? originId;
  int? publishTime;
  String? title;
  int? userId;
  int? visible;
  int? zan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['chapterId'] = chapterId;
    map['chapterName'] = chapterName;
    map['courseId'] = courseId;
    map['desc'] = desc;
    map['envelopePic'] = envelopePic;
    map['id'] = id;
    map['link'] = link;
    map['niceDate'] = niceDate;
    map['origin'] = origin;
    map['originId'] = originId;
    map['publishTime'] = publishTime;
    map['title'] = title;
    map['userId'] = userId;
    map['visible'] = visible;
    map['zan'] = zan;
    return map;
  }

}