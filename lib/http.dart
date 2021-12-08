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
const BASE_URL_ZHIHU = "https://www.zhihu.com/api/";

class Http {
  static BaseOptions optionsZhihu = BaseOptions(
    baseUrl: BASE_URL_ZHIHU,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static BaseOptions optionsWan = BaseOptions(
    baseUrl: BASE_URL_WAN_ANDROID,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static Dio dio = Dio(optionsWan)
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
    if (path.startsWith("v3")||path.startsWith("v4")) {
      dio.options = optionsZhihu;
      dio.options.headers.addAll({
        'x-api-version': '3.0.76',
        'user-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1'
      });
    } else {
      dio.options = optionsWan;
    }
    try {
      var response = await dio.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      if (response.statusCode == 200 && response.data != null) {
        return ResponseWan<R>.fromJson(response.data);
      } else {
        return Future.error(
            AppError(response.statusCode, response.statusMessage));
      }
    } on DioError catch (dioError) {
      return Future.error(AppError(AppError.ERROR_NETWORK, "网络请求失败，请稍后重试"));
    }
  }

  static Future<ResponseWan<R>> post<R>(
      String path, Map<String, dynamic>? queryParameters) async {
    try {
      if (R.toString().contains("ResponseWan")) {
        dio.options = optionsWan;
      } else if (R.toString().contains("ResponseZhihu")) {
        dio.options = optionsZhihu;
      }

      var response = await dio.post(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return ResponseWan<R>.fromJson(response.data);
      } else {
        return Future.error(
            AppError(response.statusCode, response.statusMessage));
      }
    } on DioError catch (dioError) {
      return Future.error(AppError(AppError.ERROR_NETWORK, "网络请求失败，请稍后重试"));
    }
  }
}
