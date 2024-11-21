import 'package:hive_flutter/hive_flutter.dart';

class CacheManager2 {
  static late CacheManager2 _instance;

  CacheManager2._();

  static CacheManager2 get instance => _instance;

  init() {
    _instance = CacheManager2._();
    Hive.initFlutter();
  }

  static Future<Box<T>> createBox<T>(String boxKey) {
    return Hive.openBox<T>(boxKey);
  }
}
