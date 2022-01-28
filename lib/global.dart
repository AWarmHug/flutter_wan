import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http.dart';

class Global {
  static Future<Directory> getDirectory() async {
    //path_provider相关内容 https://zhuanlan.zhihu.com/p/90071559
    ///data/user/0/com.bingo.android_wan/app_flutter
   //{"/":{"JSESSIONID":"JSESSIONID=E5D66E76EC4647D936A0F532A61F1EC4; Path=/; Secure; HttpOnly;_crt=1643350839"}}
    Directory directory;
    if (kIsWeb) {
      directory = Directory("");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory;
  }

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Rx<bool> isLogin = Rx(false);

  static Future<bool> isLogin2() async {
    Directory directory = await getDirectory();

    var cookie = await PersistCookieJar(storage: FileStorage(directory.path))
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
