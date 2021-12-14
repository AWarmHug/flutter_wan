import 'user.dart';

class ParentReply {
  int? id;
  User? user;
  String? message;
  String? imageUrl;
  String? replyStatus;

  ParentReply.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    user = User.fromMap(map["user"]);
    message = map["message"];
    imageUrl = map["imageUrl"];
    replyStatus = map["replyStatus"];
  }
}
