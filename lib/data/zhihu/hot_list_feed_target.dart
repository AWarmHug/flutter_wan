/// title_area : {"text":"立陶宛外交部副部长称「跨国企业如使用立陶宛企业的产品，将不被允许向中国进出口」，将产生哪些影响？"}
/// excerpt_area : {"text":"据路透社 12 月 9 日独家报道，立陶宛外交部副部长曼塔斯·阿多梅纳斯（Mantas Adomenas）告诉路透社，最近，中方一直向跨国公司发出信息，「如果他们使用立陶宛企业供应的零部件等产品，便将不再被允许向中国市场进出口」。 阿多梅纳斯还声称，现在，一些跨国公司已经取消了与立陶宛供应商的合同。 立陶宛工业家联盟（Lithuanian Confederation of Industrialists）向路透社证实了这一消息。 公开资料显示，该联盟是立陶宛国内大型商业中介机构，设有 37 个分会和 8 个地区协会，拥有会员企业 2700 余家，包括立陶宛大部分生产企业、银行、贸易企业、外国企业代表处、研究机构和教育机构。其会员企业几乎涵盖了立陶宛工业的各个领域，该国几乎所有的工业产品均由该联盟会员单位生产。 「本周，我们第一次看到中方直接向（跨国）供应商施压，要求他们放弃立陶宛产品。」立陶宛工业家联盟主席亚努利亚维丘斯（idmantas Janulevicius）称，「以前这只是可能发生的威胁，现在变成了现实」。 在谈到一家取消立陶宛供应商合同的跨国公司时，亚努利亚维丘斯说道：「对我们来说，最痛苦的部分是，它是一家欧洲公司。许多立陶宛企业都是此类公司的供应商。」 阿多梅纳斯和亚努利亚维丘斯均未提及受影响的公司和供应商名称。 此外，一位立陶宛政府高级官员告诉路透社，立陶宛正在考虑设立一个基金，以保护该国公司免受「中国的报复」，包括向企业提供可能的金融支持（例如贷款）。 官方数据显示，立陶宛主要贸易对象是欧盟国家，中国是其第 22 大出口目的地。但路透社提到，尽管双方直接贸易规模不大，但立陶宛有数百家公司依赖出口经济，为与中国贸易的跨国公司生产零部件、家具、服装等产品。 对此，我外交部发言人汪文斌在 12 月 9 日的例行记者会上强调，中方一贯按照‌‌世贸组织的规则办事‌。"}
/// image_area : {"url":"https://pic3.zhimg.com/v2-9c89ec86d3eb5df2805e8c84c8e3549e_b.jpg"}
/// metrics_area : {"text":"2123 万热度"}
/// label_area : {"type":"trend","trend":0,"night_color":"#B7302D","normal_color":"#F1403C"}
/// link : {"url":"https://www.zhihu.com/question/504907694"}

class Target {
  Target({
    this.titleArea,
    this.excerptArea,
    this.imageArea,
    this.metricsArea,
    this.labelArea,
    this.link,
  });

  Target.fromJson(dynamic json) {
    titleArea = json['title_area'] != null
        ? Title_area.fromJson(json['title_area'])
        : null;
    excerptArea = json['excerpt_area'] != null
        ? Excerpt_area.fromJson(json['excerpt_area'])
        : null;
    imageArea = json['image_area'] != null
        ? Image_area.fromJson(json['image_area'])
        : null;
    metricsArea = json['metrics_area'] != null
        ? Metrics_area.fromJson(json['metrics_area'])
        : null;
    labelArea = json['label_area'] != null
        ? Label_area.fromJson(json['label_area'])
        : null;
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
  }

  Title_area? titleArea;
  Excerpt_area? excerptArea;
  Image_area? imageArea;
  Metrics_area? metricsArea;
  Label_area? labelArea;
  Link? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (titleArea != null) {
      map['title_area'] = titleArea?.toJson();
    }
    if (excerptArea != null) {
      map['excerpt_area'] = excerptArea?.toJson();
    }
    if (imageArea != null) {
      map['image_area'] = imageArea?.toJson();
    }
    if (metricsArea != null) {
      map['metrics_area'] = metricsArea?.toJson();
    }
    if (labelArea != null) {
      map['label_area'] = labelArea?.toJson();
    }
    if (link != null) {
      map['link'] = link?.toJson();
    }
    return map;
  }
}

class Title_area {
  Title_area({
    this.text,
  });

  Title_area.fromJson(dynamic json) {
    text = json['text'];
  }

  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    return map;
  }
}

class Excerpt_area {
  Excerpt_area({
    this.text,
  });

  Excerpt_area.fromJson(dynamic json) {
    text = json['text'];
  }

  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    return map;
  }
}

class Image_area {
  Image_area({
    this.url,
  });

  Image_area.fromJson(dynamic json) {
    url = json['url'];
  }

  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}

class Metrics_area {
  Metrics_area({
    this.text,
  });

  Metrics_area.fromJson(dynamic json) {
    text = json['text'];
  }

  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    return map;
  }
}

class Label_area {
  Label_area({
    this.type,
    this.trend,
    this.nightColor,
    this.normalColor,
  });

  Label_area.fromJson(dynamic json) {
    type = json['type'];
    trend = json['trend'];
    nightColor = json['night_color'];
    normalColor = json['normal_color'];
  }

  String? type;
  int? trend;
  String? nightColor;
  String? normalColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['trend'] = trend;
    map['night_color'] = nightColor;
    map['normal_color'] = normalColor;
    return map;
  }
}

class Link {
  Link({
    this.url,
  });

  Link.fromJson(dynamic json) {
    url = json['url'];
  }

  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}
