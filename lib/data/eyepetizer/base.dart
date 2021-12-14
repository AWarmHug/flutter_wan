class BaseBean<T> {
  final int ERROR_404 = 404;

  /**
   * errorCode : 404
   * errorMessage : Resource Not Found
   */

  int? errorCode;

  String? errorMessage;

  T? data;



}

class HttpError {
  int code;
  String msg;

  HttpError(this.code, this.msg);


}
