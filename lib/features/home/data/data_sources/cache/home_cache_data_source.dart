import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/shared/data/local/cache_manager.dart';

class HomeCacheDataSource {
  final CacheManager cacheManager = CacheManager.instance;

  HomeCacheDataSource();

  final key = 'gifs_hive_key';

  storeGifs(List<GifResponse> gifs) async {
    await cacheManager.storeData(
        key: key, value: gifs.map((e) => e.toJson()).toList());
  }

  List<GifResponse> getStoredGifs() {
    List data = cacheManager.getData(key: key);
    return data.map((e) => GifResponse.fromJson(e)).toList();
  }
}
