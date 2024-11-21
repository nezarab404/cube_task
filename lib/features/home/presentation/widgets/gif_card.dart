import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/presentation/pages/gif_details.dart';
import 'package:cube_task/shared/components/custom_cached_image.dart';
import 'package:flutter/material.dart';

class GifCard extends StatelessWidget {
  const GifCard({super.key, required this.gifResponse});

  final GifResponse gifResponse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GifDetails.launchScreen(gif: gifResponse);
      },
      child: CustomCachedImage(
        url: gifResponse.media[0].gif.preview,
      ),
    );
  }
}
