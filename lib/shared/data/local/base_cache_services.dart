import 'cache_manager_2.dart';
import 'package:hive/hive.dart';

abstract class BaseCacheServices {
  String get boxKey;

  late Box box;

  BaseCacheServices._init();

  init() async {
    box = await CacheManager2.createBox(boxKey);
  }
}
