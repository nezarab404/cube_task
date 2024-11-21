import 'package:json_annotation/json_annotation.dart';

import 'media.dart';

part 'gif_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GifResponse {
  String id;
  // String? title;
  String contentDescription;
  // String? contentRating;
  // String? h1Title;
  List<Media> media;
  // String bgColor;
  // double created;
  // String itemurl;
  // String url;
  // List? tags;
  // List? flags;
  // int shares;
  // bool hasaudio;
  // bool hascaption;
  // String? sourceId;
  // dynamic composite;

  GifResponse(
    this.id,
    // this.title,
    this.contentDescription,
    // this.contentRating,
    // this.h1Title,
    this.media,
    // this.bgColor,
    // this.created,
    // this.itemurl,
    // this.url,
    // this.tags,
    // this.flags,
    // this.shares,
    // this.hasaudio,
    // this.hascaption,
    // this.sourceId,
    // this.composite,
  );

  factory GifResponse.fromJson(Map<String, dynamic> json) =>
      _$GifResponseFromJson(json);
}
