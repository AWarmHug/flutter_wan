import 'data/response_wan.dart';

class AppError implements Exception {
  final int code;
  final String message;

  AppError(this.code, this.message);

  AppError.from(ResponseWan responseWan)
      : this(responseWan.errorCode, responseWan.errorMsg);
}
