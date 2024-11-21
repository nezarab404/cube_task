import 'package:json_annotation/json_annotation.dart';

import 'gif_data.dart';

part 'media.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Media {
  GifData gif;

  Media(this.gif);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}
