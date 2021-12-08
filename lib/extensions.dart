import 'package:flutter_wan/error.dart';

extension FutureExt<T> on Future<T> {
  Future<T> catchAppError(void onAppError(AppError appError), {bool test(Object error)?}) {
    return catchError((error) {
      if (error is AppError) {
        onAppError(error);
      }
    }, test: test);
  }
}

extension BoolExt on bool {
  bool not() {
    return !this;
  }

  bool and(bool val) {
    return this && val;
  }

  bool or(bool val) {
    return this || val;
  }
}

extension StringExt on String {
  double toDouble() {
    return double.parse(this);
  }
  int toInt() {
    return int.parse(this);
  }
  bool isMobile(){
    return RegExp(r'^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8])|(19)[0-9])\d{8}$').hasMatch(this);
  }
}