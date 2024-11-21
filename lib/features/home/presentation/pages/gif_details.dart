import 'package:cube_task/shared/components/app_text.dart';
import 'package:cube_task/shared/components/custom_app_bar.dart';
import 'package:cube_task/shared/components/custom_cached_image.dart';
import 'package:cube_task/shared/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import '../../../../shared/routing/router.dart';
import '../../../../shared/routing/routes_paths.dart';
import '../../data/models/gif_response.dart';

class GifDetails extends StatelessWidget {
  const GifDetails({super.key, required this.gif});

  final GifResponse gif;

  static launchScreen({
    required GifResponse gif,
  }) =>
      AppRouter.push(
        RoutesPaths.gifDetails,
        extra: gif,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(
        title: 'Gif Details',
        hideLeading: false,
      ),
      body: Padding(
        padding: UIHelper.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2, child: CustomCachedImage(url: gif.media[0].gif.url)),
            UIHelper.verticalSpaceMedium(),
            Expanded(
              flex: 1,
              child: AppText(
                text: gif.contentDescription,
                fontSize: 14,
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
