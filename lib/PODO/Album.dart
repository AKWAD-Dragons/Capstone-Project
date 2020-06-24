import 'package:json_annotation/json_annotation.dart';
part 'Album.g.dart';

@JsonSerializable()
class Album {
  String id;
  String image_link;
  @JsonKey(ignore: true, defaultValue: false)
  bool isByte;
  Album({this.id, this.image_link, this.isByte});
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  bool operator ==(Object album) {
    if (album is Album) return album.image_link == this.image_link;

    return false;
  }

  @override
  String toString() {
    return "{id : \"$id\" ,image_link: \"$image_link\"  }";
  }
}
