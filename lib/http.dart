import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/response_wan.dart';

const BASE_URL_WAN_ANDROID = "https://www.wanandroid.com/";

class Http {
  static BaseOptions options = BaseOptions(
    baseUrl: BASE_URL_WAN_ANDROID,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio dio = Dio(options)
    ..interceptors.add(CookieManager(
        PersistCookieJar(storage: FileStorage(Global.directory.path))))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  static Future<ResponseWan<R>> get<R>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200 && response.data != null) {
      return ResponseWan<R>.fromJson(response.data);
    } else {
      return Future.error(AppError(-1000, "网络请求异常"));
    }
  }

  static Future<ResponseWan<R>> post<R>(
      String path, Map<String, dynamic>? queryParameters) async {
    var response = await dio.post(path, queryParameters: queryParameters);
    if (response.statusCode == 200 && response.data != null) {
      return ResponseWan<R>.fromJson(response.data);
    } else {
      return Future.error(AppError(-1000, "网络请求异常"));
    }
  }
}
