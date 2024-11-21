import 'package:shared_preferences/shared_preferences.dart';

//TODO : Secure with flutter_secure_storage
class LocalStorage {
  static const String _tokenKey = 'token';
  static const String _languageKey = 'language';

  final SharedPreferences _sharedPreferences;

  LocalStorage(this._sharedPreferences);

  Future<bool> storeToken(String token) async {
    return _sharedPreferences.setString(_tokenKey, token);
  }

  String? get token => _sharedPreferences.getString(_tokenKey);

  Future<bool> clearToken() async => _sharedPreferences.remove(_tokenKey);

  Future<bool> storeLanguage(String lang) async =>
      _sharedPreferences.setString(_languageKey, lang);

  String? get language => _sharedPreferences.getString(_languageKey);

  Future<bool> clearLanguage() async => _sharedPreferences.remove(_languageKey);
}
