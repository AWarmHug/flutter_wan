import 'package:flutter_wan/error.dart';
import 'package:date_format/date_format.dart';

extension FutureExt<T> on Future<T> {
  Future<T> catchAppError(void onAppError(AppError appError),
      {bool test(Object error)?}) {
    return catchError((error) {
      if (error is AppError) {
        onAppError(error);
      }else{
        onAppError(AppError(AppError.ERROR_UNKNOWN,error.toString()));
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

extension IntExt on int {
  DateTime date() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

extension DateTimeExt on DateTime {
  String format() {
    var now = DateTime.now();
    if (now.millisecondsSinceEpoch - this.millisecondsSinceEpoch >=
        24 * 60 * 60 * 1000) {
      //大于一天，显示日期
      return formatDate(this, [mm, '-', dd, ' ', HH, ":", nn]);
    } else {
      //小于一天，显示多少小时前
      if (now.hour - this.hour >= 1) {
        //大于一小时，显示多少小时前
        return "${now.hour - this.hour}小时前";
      } else {
        //小于一小时，显示多少分钟前
        if (now.minute - this.minute >= 5) {
          //大于5分钟，显示多少分钟前
          return "${now.minute - this.minute}分钟前";
        } else {
          return "刚刚";
        }
      }
    }
  }
}

extension StringExt on String {
  double toDouble() {
    return double.parse(this);
  }

  int toInt() {
    return int.parse(this);
  }

  bool isMobile() {
    return RegExp(
            r'^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8])|(19)[0-9])\d{8}$')
        .hasMatch(this);
  }
}
