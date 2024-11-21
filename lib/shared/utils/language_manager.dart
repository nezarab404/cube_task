import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/local/local_storage.dart';
import '../di/app_di.dart';

abstract class LanguagesManager {
  static Locale get englishLocale => const Locale('en');

  static Locale get arabicLocale => const Locale('ar');

  static List<Locale> get allLocales => [
        arabicLocale,
        englishLocale,
      ];

  static void setLocale(BuildContext context, Locale locale) {
    if (allLocales.contains(locale)) {
      context.setLocale(locale);
      getIt.get<LocalStorage>().storeLanguage(locale.toStringWithSeparator());
    } else {
      throw Exception('App does not support this locale');
    }
  }

  static Locale get getCurrentLocale {
    Locale defaultLocale = englishLocale;

    String? temp = getIt.get<LocalStorage>().language;
    if (temp == null) {
      return defaultLocale;
    } else {
      switch (temp) {
        case 'ar':
          return arabicLocale;
        case 'en':
          return englishLocale;
        default:
          return defaultLocale;
      }
    }
  }

  static bool get isArabic => getCurrentLocale == arabicLocale;

  static bool get isEnglish => getCurrentLocale == englishLocale;
}
