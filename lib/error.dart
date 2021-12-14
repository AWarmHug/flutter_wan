import 'data/response_wan.dart';

class AppError implements Exception {
  static const int ERROR_NETWORK = -1;
  static const int ERROR_NO_DATA = -2;

  static const int ERROR_UNKNOWN = -3;


  int? code;
  String? message;

  AppError(this.code, this.message);

  AppError.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['code'] = code;
    return map;
  }

  AppError.noData() : this(ERROR_NO_DATA, "没有更多数据");
}
