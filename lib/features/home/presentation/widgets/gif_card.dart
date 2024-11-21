import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/shared/components/custom_cached_image.dart';
import 'package:flutter/material.dart';

class GifCard extends StatelessWidget {
  const GifCard({super.key, required this.gifResponse});

  final GifResponse gifResponse;

  @override
  Widget build(BuildContext context) {
    return CustomCachedImage(
      url: gifResponse.media[0].gif.preview,
    );
  }
}
