/// id : 6
/// link : ""
/// name : "面试"
/// order : 1
/// visible : 1

class HotKey {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotKey({
      this.id, 
      this.link, 
      this.name, 
      this.order, 
      this.visible});

  HotKey.fromJson(dynamic json) {
    id = json["id"];
    link = json["link"];
    name = json["name"];
    order = json["order"];
    visible = json["visible"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["link"] = link;
    map["name"] = name;
    map["order"] = order;
    map["visible"] = visible;
    return map;
  }

}