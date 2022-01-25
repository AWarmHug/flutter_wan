import 'dart:convert';

import 'package:flutter/services.dart';


class MethodChannels {
  static const CHANNEL_NAME = "com.bingo/method_channel";
  static const _methodChannel = MethodChannel(CHANNEL_NAME);


  static Future<T> routeNative<T>(String route) async {
    Map<String, dynamic> map = {
      "route": route,
    };
    T value = await _methodChannel.invokeMethod("route", map);
    return value;
  }

}
