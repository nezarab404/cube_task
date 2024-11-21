import 'package:bot_toast/bot_toast.dart';
import 'theme/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/codegen_loader.g.dart';
import 'routing/router.dart';
import 'utils/language_manager.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  Size get designSize => const Size(375, 812);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: LanguagesManager.allLocales,
      path: 'assets/i18n',
      fallbackLocale: LanguagesManager.englishLocale,
      startLocale: LanguagesManager.getCurrentLocale,
      saveLocale: false,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (
          BuildContext context,
          Widget? widgetChild,
        ) =>
            ValueListenableBuilder<ThemeMode>(
          valueListenable: AppThemes.themeNotifier,
          builder: (BuildContext context, ThemeMode value, Widget? child) {
            return MaterialApp.router(
              title: 'Gif Task',
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: value,
              builder: BotToastInit(),
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              routerConfig: AppRouter.getRouter,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
