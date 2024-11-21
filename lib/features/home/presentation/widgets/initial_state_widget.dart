import 'package:flutter/material.dart';

import '../../../../shared/components/app_text.dart';

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppText(text: 'Search for a GIF !'),
    );
  }
}
