import 'package:json_annotation/json_annotation.dart';

import 'gif_response.dart';

part 'gif_response_data.g.dart';

@JsonSerializable()
class GifResponseData {
  List<GifResponse> results;
  String next;

  GifResponseData(this.results, this.next);

  factory GifResponseData.fromJson(Map<String, dynamic> json) =>
      _$GifResponseDataFromJson(json);
}
