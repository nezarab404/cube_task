import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO : Secure with flutter_secure_storage
class LocalStorage {
  static const String _languageKey = 'language';
  static const String _themeKey = 'theme';

  final SharedPreferences _sharedPreferences;

  LocalStorage(this._sharedPreferences);

  Future<bool> storeLanguage(String lang) async =>
      _sharedPreferences.setString(_languageKey, lang);

  String? get language => _sharedPreferences.getString(_languageKey);

  Future<bool> clearLanguage() async => _sharedPreferences.remove(_languageKey);

  Future<bool> storeTheme(int theme) async =>
      _sharedPreferences.setInt(_themeKey, theme);

  int get theme => _sharedPreferences.getInt(_themeKey) ?? 0;

  Future<bool> clearTheme() async => _sharedPreferences.remove(_themeKey);
}
