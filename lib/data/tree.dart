/// children : []
/// courseId : 13
/// id : 168
/// name : "Drawable"
/// order : 5000
/// parentChapterId : 167
/// userControlSetTop : false
/// visible : 1

class Tree {
  List<Tree>? children;
  int? courseId;
  int? id;
  String? name;
  int? order;
  int? parentChapterId;
  bool? userControlSetTop;
  int? visible;

  Tree(
      {this.children,
      this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  Tree.fromJson(dynamic json) {
    if (json["children"] != null) {
      children = [];
      json["children"].forEach((v) {
        children?.add(Tree.fromJson(v));
      });
    }
    courseId = json["courseId"];
    id = json["id"];
    name = json["name"];
    order = json["order"];
    parentChapterId = json["parentChapterId"];
    userControlSetTop = json["userControlSetTop"];
    visible = json["visible"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (children != null) {
      map["children"] = children?.map((v) => v.toJson()).toList();
    }
    map["courseId"] = courseId;
    map["id"] = id;
    map["name"] = name;
    map["order"] = order;
    map["parentChapterId"] = parentChapterId;
    map["userControlSetTop"] = userControlSetTop;
    map["visible"] = visible;
    return map;
  }
}
