class PlayInfo {
  /**
   * height : 720
   * width : 1280
   * urlList : [{"name":"aliyun","url":"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=high&source=aliyun","size":60891024},{"name":"qcloud","url":"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=high&source=qcloud","size":60891024},{"name":"ucloud","url":"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=high&source=ucloud","size":60891024}]
   * name : 高清
   * type : high
   * url : http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=high&source=aliyun
   */

  int? height;
  int? width;
  String? name;
  String? type;
  String? url;
  List<UrlList> urlList = [];
}

/**
 * name : aliyun
 * url : http://baobab.kaiyanapp.com/api/v1/playUrl?vid=1130&resourceType=video&editionType=high&source=aliyun
 * size : 60891024
 */
class UrlList {
  String? name;
  String? url;
  int? size;
}
