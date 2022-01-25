import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http.dart';

class Global {
  static late SharedPreferences prefs;
  //path_provider相关内容 https://zhuanlan.zhihu.com/p/90071559
  static late Directory directory;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    if(kIsWeb){
      directory =Directory("");
    }else {
      directory = await getApplicationDocumentsDirectory();
    }
  }

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");


  static Rx<bool> isLogin = Rx(false);

  static Future<bool> isLogin2() async {
    var cookie =
        await PersistCookieJar(storage: FileStorage(Global.directory.path))
            .loadForRequest(Uri.parse(BASE_URL_WAN_ANDROID));
    Cookie? cookieToken;
    cookie.forEach((element) {
      if (element.name == "token_pass") {
        cookieToken = element;
        return;
      }
    });
    return cookieToken != null;
  }
}
