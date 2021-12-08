import 'package:flutter_wan/extensions.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// play_url : "https://vdn5.vzuu.com/mediacloud/catchingfire/video/c6dc4cce53eed0f4-6c232a094497bc2147d790379d196c18-480p_mp4_h265_1.mp4?pkey=AAX6XVOuZkjoOUT-Gs8-y927HlZzNak_11TzlFYlWzhKP2V_bplcd-lMY193iVakZp9e4iZu9mNNUnSmJd6epx4c"
/// bitrate : 521
/// duration : 131.936009
/// format : "mp4"
/// fps : 24.9848484848
/// size : 8616304
/// height : 852
/// width : 480
/// channels : 2
/// sample_rate : 44100
/// url : "https://vdn5.vzuu.com/mediacloud/catchingfire/video/c6dc4cce53eed0f4-6c232a094497bc2147d790379d196c18-480p_mp4_h265_1.mp4?pkey=AAX6XVOuZkjoOUT-Gs8-y927HlZzNak_11TzlFYlWzhKP2V_bplcd-lMY193iVakZp9e4iZu9mNNUnSmJd6epx4c"

class PlayItem {
  PlayItem({
    this.playUrl,
    this.bitrate,
    this.duration,
    this.format,
    this.fps,
    this.size,
    this.height,
    this.width,
    this.channels,
    this.sampleRate,
    this.url,
  });

  PlayItem.fromJson(dynamic json) {
    playUrl = json['play_url'];
    bitrate = json['bitrate'].toString().toDouble();
    duration = json['duration'].toString().toDouble();
    format = json['format'];
    fps = json['fps'].toString().toDouble();
    size = json['size'];
    height = json['height'];
    width = json['width'];
    channels = json['channels'];
    sampleRate = json['sample_rate'];
    url = json['url'];
  }

  String? playUrl;
  double? bitrate;
  double? duration;
  String? format;
  double? fps;
  int? size;
  int? height;
  int? width;
  int? channels;
  int? sampleRate;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['play_url'] = playUrl;
    map['bitrate'] = bitrate;
    map['duration'] = duration;
    map['format'] = format;
    map['fps'] = fps;
    map['size'] = size;
    map['height'] = height;
    map['width'] = width;
    map['channels'] = channels;
    map['sample_rate'] = sampleRate;
    map['url'] = url;
    return map;
  }
}

class Playlist {
  Playlist({
    this.fhd,
    this.hd,
    this.ld,
    this.sd,
  });

  Playlist.fromJson(dynamic json) {
    fhd = json['fhd'] != null ? PlayItem.fromJson(json['fhd']) : null;
    hd = json['hd'] != null ? PlayItem.fromJson(json['hd']) : null;
    ld = json['ld'] != null ? PlayItem.fromJson(json['ld']) : null;
    sd = json['sd'] != null ? PlayItem.fromJson(json['sd']) : null;
  }

  PlayItem? fhd;
  PlayItem? hd;
  PlayItem? ld;
  PlayItem? sd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fhd != null) {
      map['fhd'] = fhd?.toJson();
    }
    if (hd != null) {
      map['hd'] = hd?.toJson();
    }
    if (ld != null) {
      map['ld'] = ld?.toJson();
    }
    if (sd != null) {
      map['sd'] = sd?.toJson();
    }
    return map;
  }
}


class Playlist_v2 {
  Playlist_v2({
    this.fhd,
    this.hd,
    this.ld,
    this.sd,
  });

  Playlist_v2.fromJson(dynamic json) {
    fhd = json['fhd'] != null ? PlayItem.fromJson(json['fhd']) : null;
    hd = json['hd'] != null ? PlayItem.fromJson(json['hd']) : null;
    ld = json['ld'] != null ? PlayItem.fromJson(json['ld']) : null;
    sd = json['sd'] != null ? PlayItem.fromJson(json['sd']) : null;
  }

  PlayItem? fhd;
  PlayItem? hd;
  PlayItem? ld;
  PlayItem? sd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fhd != null) {
      map['fhd'] = fhd?.toJson();
    }
    if (hd != null) {
      map['hd'] = hd?.toJson();
    }
    if (ld != null) {
      map['ld'] = ld?.toJson();
    }
    if (sd != null) {
      map['sd'] = sd?.toJson();
    }
    return map;
  }
}