import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import 'data/response_wan.dart';
import 'data/zhihu/answer_comments.dart';

//知乎视频
//https://www.zhihu.com/api/v4/zvideo-tabs/tabs/choice/feeds/recommend?limit=12
//视频评论
//https://www.zhihu.com/api/v4/zvideos/1450123358607867904/root_comments?order=normal&limit=20&offset=0&status=open

//知乎热门
//https://www.zhihu.com/api/v3/feed/topstory/hot-list-web?limit=50&desktop=true

//所有回答
//https://www.zhihu.com/api/v4/questions/505809178/answers?include=data%5B*%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%2Cis_recognized%3Bdata%5B*%5D.mark_infos%5B*%5D.url%3Bdata%5B*%5D.author.follower_count%2Cvip_info%2Cbadge%5B*%5D.topics%3Bdata%5B*%5D.settings.table_of_content.enabled&offset=0&limit=20&sort_by=updated
//https://www.zhihu.com/api/v4/questions/505806765/answers?include=data%5B%2A%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%2Cis_recognized%3Bdata%5B%2A%5D.mark_infos%5B%2A%5D.url%3Bdata%5B%2A%5D.author.follower_count%2Cvip_info%2Cbadge%5B%2A%5D.topics%3Bdata%5B%2A%5D.settings.table_of_content.enabled&limit=5&offset=5&platform=desktop&sort_by=default

//问题相关的问题
//https://www.zhihu.com/api/v4/questions/505806765/similar-questions?include=data%5B*%5D.answer_count%2Cauthor%2Cfollower_count&limit=5

//根据id查找问题
//https://api.zhihu.com/questions/505809178

//获取列表
//https://www.zhihu.com/api/v3/feed/topstory/hot-lists/total?limit=50&mobile=true
//https://www.zhihu.com/api/v3/feed/topstory/hot-lists/science?limit=50&mobile=true

const List<Tuple2<String, String>> HOT_LIST_TYPE = [
  Tuple2("全站", "total"),
  Tuple2("科学", "science"),
  Tuple2("数码", "digital"),
  Tuple2("体育", "sport"),
  Tuple2("时尚", "fashion"),
  Tuple2("影视", "film"),
  Tuple2("校园", "school"),
  Tuple2("汽车", "car"),
  Tuple2("时事", "depth"),
  Tuple2("国际", "focus"),
];

//根据回答问题id获取更多问题
//https://www.zhihu.com/api/v4/hot_recommendation?show_ad=true&source=question&source_id=506002000&utm_source=

const BASE_URL_WAN_ANDROID = "https://www.wanandroid.com/";
const BASE_URL_ZHIHU = "https://www.zhihu.com/api/";

const BASE_URL_KAIYAN = "http://baobab.kaiyanapp.com/api/";

class Http {
  static BaseOptions _optionsKaiyan = BaseOptions(
    baseUrl: kIsWeb ? "http://localhost:4502/" : BASE_URL_KAIYAN,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static BaseOptions _optionsZhihu = BaseOptions(
    baseUrl: kIsWeb ? "http://localhost:4501/" : BASE_URL_ZHIHU,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static BaseOptions _optionsWan = BaseOptions(
    baseUrl: kIsWeb ? "http://localhost:4500/" : BASE_URL_WAN_ANDROID,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  static Dio dio = kIsWeb ? dio4web() : dio2();

  static Dio dio4web() {
    return Dio(_optionsWan)
      // ..interceptors.add(CookieManager(
      //     PersistCookieJar(storage: FileStorage(Global.directory.path))))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static Dio dio2() {
    return Dio(_optionsWan)
      ..interceptors.add(CookieManager(
          PersistCookieJar(storage: FileStorage(Global.directory.path))))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (path.startsWith("v3") || path.startsWith("v4")) {
      dio.options = _optionsZhihu;
      // dio.options.headers.addAll({
      //   'x-api-version': '3.0.76',
      //   'user-agent':
      //       'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1'
      // });
    } else {
      dio.options = _optionsWan;
    }
    try {
      var response = await dio.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      } else {
        return Future.error(
            AppError(response.statusCode, response.statusMessage));
      }
    } on DioError catch (dioError) {
      return Future.error(
          AppError(AppError.ERROR_NETWORK, "网络请求失败，请稍后重试"), StackTrace.current);
    }
  }

  static Future<R> get2<R extends ResponseWan, T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var json = await _get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);

    if (R.toString().contains("AnswerComments")) {
      return AnswerComments.fromJson(json) as R;
    } else {
      return ResponseWan<T>.fromJson(json) as R;
    }
  }

  static Future<ResponseWan<R>> get<R>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return get2<ResponseWan<R>, R>(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  static Future<ResponseWan<R>> post<R>(
      String path, Map<String, dynamic>? queryParameters) async {
    try {
      if (R.toString().contains("ResponseWan")) {
        dio.options = _optionsWan;
      } else if (R.toString().contains("ResponseZhihu")) {
        dio.options = _optionsZhihu;
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
