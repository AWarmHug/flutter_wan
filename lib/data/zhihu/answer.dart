import 'author.dart';
import 'question.dart';
import 'relationship.dart';
import 'video.dart';
import 'video_item.dart';
import 'zvideo.dart';

class Answer extends VideoItem {
  Answer.fromJson(dynamic json) {
    id = json['id'];
    contentId = json['content_id'];
    type = json['type'];
    answerType = json['answer_type'];
    excerpt = json['excerpt'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    question =
        json['question'] != null ? Question.fromJson(json['question']) : null;
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
    playCount = json['play_count'];
    commentCount = json['comment_count'];
    voteupCount = json['voteup_count'];
    thanksCount = json['thanks_count'];
    favlistsCount = json['favlists_count'];
    shareCount = json['share_count'];
    isFavorited = json['is_favorited'];
    commentPermission = json['comment_permission'];
    isVisible = json['is_visible'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
    relationship = json['relationship'] != null
        ? Relationship.fromJson(json['relationship'])
        : null;
    attachedInfo = json['attached_info'];
    friendInteraction = json['friend_interaction'] != null
        ? Friend_interaction.fromJson(json['friend_interaction'])
        : null;
    hasColumn = json['has_column'];
    adminClosedComment = json['admin_closed_comment'];
  }

  String? answerType;
  String? excerpt;
  int? createdAt;
  int? updatedAt;
  int? createdTime;
  int? updatedTime;
  Question? question;
  Video? video;
  int? playCount;
  int? commentCount;
  int? voteupCount;
  int? thanksCount;
  int? favlistsCount;
  int? shareCount;
  bool? isFavorited;
  String? commentPermission;
  Attachment? attachment;
  Relationship? relationship;
  String? attachedInfo;
  Friend_interaction? friendInteraction;
  bool? hasColumn;
  bool? adminClosedComment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content_id'] = contentId;
    map['type'] = type;
    map['answer_type'] = answerType;
    map['excerpt'] = excerpt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_time'] = createdTime;
    map['updated_time'] = updatedTime;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (question != null) {
      map['question'] = question?.toJson();
    }
    if (video != null) {
      map['video'] = video?.toJson();
    }
    map['play_count'] = playCount;
    map['comment_count'] = commentCount;
    map['voteup_count'] = voteupCount;
    map['thanks_count'] = thanksCount;
    map['favlists_count'] = favlistsCount;
    map['share_count'] = shareCount;
    map['is_favorited'] = isFavorited;
    map['comment_permission'] = commentPermission;
    map['is_visible'] = isVisible;
    if (attachment != null) {
      map['attachment'] = attachment?.toJson();
    }
    if (relationship != null) {
      map['relationship'] = relationship?.toJson();
    }
    map['attached_info'] = attachedInfo;
    if (friendInteraction != null) {
      map['friend_interaction'] = friendInteraction?.toJson();
    }
    map['has_column'] = hasColumn;
    map['admin_closed_comment'] = adminClosedComment;
    return map;
  }
}

class Attachment {
  Attachment({
    this.type,
    this.attachmentId,
    this.video,
  });

  Attachment.fromJson(dynamic json) {
    type = json['type'];
    attachmentId = json['attachment_id'];
    video =
        json['video'] != null ? AttachmentVideo.fromJson(json['video']) : null;
  }

  String? type;
  String? attachmentId;
  AttachmentVideo? video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['attachment_id'] = attachmentId;
    if (video != null) {
      map['video'] = video?.toJson();
    }
    return map;
  }
}

class AttachmentVideo {
  AttachmentVideo({
    this.subVideoId,
    this.zvideoId,
    this.parentVideoId,
    this.startTime,
    this.endTime,
    this.isFragment,
    this.videoInfo,
  });

  AttachmentVideo.fromJson(dynamic json) {
    subVideoId = json['sub_video_id'];
    zvideoId = json['zvideo_id'];
    parentVideoId = json['parent_video_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isFragment = json['is_fragment'];
    videoInfo = json['video_info'] != null
        ? Video_info.fromJson(json['video_info'])
        : null;
  }

  String? subVideoId;
  String? zvideoId;
  String? parentVideoId;
  int? startTime;
  int? endTime;
  bool? isFragment;
  Video_info? videoInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_video_id'] = subVideoId;
    map['zvideo_id'] = zvideoId;
    map['parent_video_id'] = parentVideoId;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['is_fragment'] = isFragment;
    if (videoInfo != null) {
      map['video_info'] = videoInfo?.toJson();
    }
    return map;
  }
}

