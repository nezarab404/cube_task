import 'package:json_annotation/json_annotation.dart';

import 'media.dart';

part 'gif_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GifResponse {
  String id;
  String contentDescription;
  List<Media> media;

  GifResponse(
    this.id,
    this.contentDescription,
    this.media,
  );

  factory GifResponse.fromJson(Map<String, dynamic> json) =>
      _$GifResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GifResponseToJson(this);
}
