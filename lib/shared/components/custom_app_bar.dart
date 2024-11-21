import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routing/router.dart';
import '../theme/app_colors.dart';
import 'app_text.dart';

abstract final class CustomAppBar {
  static AppBar createAppBar({
    required String title,
    bool hideLeading = false,
    List<Widget> actions = const [],
  }) =>
      AppBar(
        title: FittedBox(
          child: _buildTitle(title),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: true,
        actions: actions,
        leading: hideLeading
            ? null
            : IconButton(
                onPressed: () {
                  AppRouter.getRouter.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: kDefaultFontSize.sp,
                ),
              ),
        toolbarHeight: kToolbarHeight.h,
      );

  static AppText _buildTitle(String title) {
    return AppText(
      text: title,
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}
