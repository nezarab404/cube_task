import 'package:cube_task/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'app_text.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({super.key, required this.onRefresh, this.error});

  final void Function() onRefresh;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (error != null && error!.isNotEmpty)
            AppText(
              text: error!,
              maxLines: 10,
            ),
          TextButton.icon(
            onPressed: onRefresh,
            icon: Icon(
              Icons.refresh,
              color: AppColors.primary,
              size: kDefaultFontSize.sp,
            ),
            label: AppText(
              text: LocaleKeys.try_again.tr(),
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
