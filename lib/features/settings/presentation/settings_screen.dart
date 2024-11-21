import 'package:cube_task/generated/locale_keys.g.dart';
import 'package:cube_task/shared/components/app_text.dart';
import 'package:cube_task/shared/components/custom_app_bar.dart';
import 'package:cube_task/shared/theme/app_themes.dart';
import 'package:cube_task/shared/utils/language_manager.dart';
import 'package:cube_task/shared/utils/ui_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/routing/router.dart';
import '../../../shared/routing/routes_paths.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static launchScreen() => AppRouter.push(RoutesPaths.settings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(
        title: LocaleKeys.settings.tr(),
        hideLeading: false,
      ),
      body: Padding(
        padding: UIHelper.pagePadding,
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: AppText(text: LocaleKeys.language.tr()),
                subtitle: AppText(text: LocaleKeys.change_language.tr()),
                onTap: () {
                  LanguagesManager.setLocale(
                    context,
                    LanguagesManager.isArabic
                        ? LanguagesManager.englishLocale
                        : LanguagesManager.arabicLocale,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: AppText(text: LocaleKeys.theme.tr()),
                subtitle: ValueListenableBuilder<ThemeMode>(
                  valueListenable: AppThemes.themeNotifier,
                  builder:
                      (BuildContext context, ThemeMode value, Widget? child) {
                    return AppText(text: value.name);
                  },
                ),
                onTap: () {
                  AppThemes.changeThemeMode(
                    AppThemes.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : AppThemes.themeNotifier.value == ThemeMode.dark
                            ? ThemeMode.system
                            : ThemeMode.light,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
