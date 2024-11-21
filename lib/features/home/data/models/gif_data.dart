import 'package:json_annotation/json_annotation.dart';

part 'gif_data.g.dart';

@JsonSerializable()
class GifData {
  num size;
  List<int> dims;
  num duration;
  String url;
  String preview;

  GifData(
    this.size,
    this.dims,
    this.duration,
    this.url,
    this.preview,
  );

  factory GifData.fromJson(Map<String, dynamic> json) =>
      _$GifDataFromJson(json);
}
