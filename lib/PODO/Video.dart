import 'package:json_annotation/json_annotation.dart';
part 'Video.g.dart';

@JsonSerializable()
class Video {
  String id;
  String video_link;
  @JsonKey(ignore: true, defaultValue: false)
  bool isByte;
  Video({this.id, this.video_link, this.isByte});
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  @override
  bool operator ==(Object video) {
    if (video is Video) return video.video_link == this.video_link;

    return false;
  }

  @override
  String toString() {
    return "{id : \"$id\" ,video_link: \"$video_link\"  }";
  }
}
