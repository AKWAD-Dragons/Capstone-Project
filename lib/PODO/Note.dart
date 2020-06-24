import 'package:json_annotation/json_annotation.dart';

part 'Note.g.dart';

@JsonSerializable()
class Note {
  String description;
  String date;
  String section;

  Note(
    this.description,
    this.date,
      this.section
  );
  Note.empty();

  factory Note.fromJson(Map<String, dynamic> json) =>
      _$NoteFromJson(json);
}
