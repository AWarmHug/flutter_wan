/// type : "identity"
/// topics : null
/// description : "生活领域答主"

class Badge {
  Badge({
      this.type, 
      this.topics, 
      this.description,});

  Badge.fromJson(dynamic json) {
    type = json['type'];
    topics = json['topics'];
    description = json['description'];
  }
  String? type;
  dynamic topics;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['topics'] = topics;
    map['description'] = description;
    return map;
  }

}