import 'data/response_wan.dart';

class AppError implements Exception {
  static const int ERROR_NETWORK=-1;
  static const int ERROR_NO_DATA=-2;


  final int? code;
  final String? message;

  AppError(this.code, this.message);

  AppError.from(ResponseWan responseWan)
      : this(responseWan.errorCode, responseWan.errorMsg);

  AppError.noData():this(ERROR_NO_DATA,"没有更多数据");
}
