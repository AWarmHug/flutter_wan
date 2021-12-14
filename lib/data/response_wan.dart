import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/hot_list_feed.dart';
import 'package:flutter_wan/error.dart';
import 'package:flutter_wan/data/zhihu/paging.dart';

import 'article.dart';
import 'banner.dart';
import 'collect.dart';
import 'data_list.dart';
import 'navigation.dart';
import 'search.dart';
import 'tree.dart';
import 'user.dart' as WanUser;
import 'zhihu/answer.dart';
import 'zhihu/answer_comment.dart';
import 'zhihu/answer_list_item.dart';
import 'zhihu/video_item.dart';
import 'zhihu/zvideo.dart';

/// data : {"curPage":1,"datas":[],"offset":0,"over":false,"pageCount":554,"size":20,"total":11072}
/// errorCode : 0
/// errorMsg : ""

class ResponseWan<T> {
  T? data;

  Paging? paging;

  AppError? error;

  bool get isSuccess {
    return error == null;
  }

  ResponseWan.fromJson(dynamic json) {
    if (T.toString() == ("dynamic")) {
      data = json["data"];
    }

    if (T.toString() == ("ListData<Article>")) {
      data = json["data"] != null
          ? ListData<Article>.fromJson(json["data"]) as T
          : null;
    }

    if (T.toString() == ("ListData<Collect>")) {
      data = json["data"] != null
          ? ListData<Collect>.fromJson(json["data"]) as T
          : null;
    }

    if (T.toString().contains("List")) {
      if (json["data"] != null) {
        if (T.toString() == "List<BannerItem>") {
          var d = <BannerItem>[];
          json["data"].forEach((v) {
            d.add(BannerItem.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<Tree>") {
          var d = <Tree>[];
          json["data"].forEach((v) {
            d.add(Tree.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<HotKey>") {
          var d = <HotKey>[];
          json["data"].forEach((v) {
            d.add(HotKey.fromJson(v));
          });
          data = d as T;
        }
        if (T.toString() == "List<Navigation>") {
          var d = <Navigation>[];
          json["data"].forEach((v) {
            d.add(Navigation.fromJson(v));
          });
          data = d as T;
        }

        if (T.toString() == "List<VideoItem>") {
          var items = <VideoItem>[];
          json["data"].forEach((v) {
            if (v['type'] == "zvideo") {
              items.add(ZVideo.fromJson(v));
            } else if (v['type'] == "answer") {
              items.add(Answer.fromJson(v));
            }
          });
          data = items as T;
        }

        if (T.toString() == "List<HotListFeed>") {
          var d = <HotListFeed>[];
          json["data"].forEach((v) {
            d.add(HotListFeed.fromJson(v));
          });
          data = d as T;
        }

        if (T.toString() == "List<FeedItem>") {
          var d = <FeedItem>[];
          json["data"].forEach((v) {
            d.add(FeedItem.fromJson(v));
          });
          data = d as T;
        }

        if (T.toString() == "List<AnswerComment>") {
          var d = <AnswerComment>[];
          json["data"].forEach((v) {
            d.add(AnswerComment.fromJson(v));
          });
          data = d as T;
        }

        if (T.toString() == "List<AnswerListItem>") {
          var d = <AnswerListItem>[];
          json["data"].forEach((v) {
            d.add(AnswerListItem.fromJson(v));
          });
          data = d as T;
        }

      }

    }


    if (T.toString() == "User") {
      data = json["data"] != null
          ? WanUser.User.fromJson(json["data"]) as T
          : null;
    }

    if (T.toString() == "UserInfo") {
      data = json["data"] != null
          ? WanUser.UserInfo.fromJson(json["data"]) as T
          : null;
    }

    paging = json["paging"] != null ? Paging.fromJson(json["paging"]) : null;

    if (json["errorCode"] != null) {
      if (json["errorCode"] != 0) {
        error =
            AppError(json["errorCode"] as int?, json["errorMsg"] as String?);
      }
    } else {
      error = json["error"] != null ? AppError.fromJson(json["error"]) : null;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      if (data is ListData?) {
        ListData n = data as ListData;
        map["data"] = n.toJson();
      }
    }
    if (error != null) {
      map["error"] = error?.toJson();
    }
    return map;
  }

  get errorCode {
    return error?.code;
  }

  get errorMsg {
    return error?.message;
  }
}
