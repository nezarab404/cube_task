import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class CacheManager {
  static late CacheManager _instance;
  static const String _boxName = 'cacheBox';
  static late Box _box;

  CacheManager._();

  static CacheManager get instance => _instance;

  static init() async {
    _instance = CacheManager._();
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  Future<void> storeData({
    required String key,
    required dynamic value,
  }) async {
    await _box.put(key, jsonEncode(value));
    await _box.compact();
  }

  getData({
    required String key,
    dynamic defaultValue,
  }) {
    return _box.get(jsonDecode(key), defaultValue: defaultValue);
  }

  Future<void> clearData({
    required String key,
  }) async {
    await _box.delete(key);
    await _box.compact();
  }
}
