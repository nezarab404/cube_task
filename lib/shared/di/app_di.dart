import '../../features/home/data/repositories/home_repo.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/data_sources/remote/home_data_source.dart';
import '../data/local/local_storage.dart';
import '../data/network/interceptor.dart';
import '../utils/dotenv_keys.dart';

final getIt = GetIt.instance;

class AppDI {
  static setup() async {
    await _setupLocalStorage();
    _injectNetworkingDependencies();
    _injectRepositories();
    _injectUseCases();
    _injectCubits();
  }

  static _injectCubits() {
    getIt.registerFactory(() => HomeCubit(getIt()));
  }

  static _injectRepositories() {
    getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  }

  static _injectUseCases() {}

  static Future _setupLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    getIt.registerSingleton<LocalStorage>(LocalStorage(pref));
  }

  static Dio _injectDio() {
    Dio dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(AppInterceptor());
    getIt.registerSingleton<Dio>(dio);
    return dio;
  }

  static _injectApiServices(Dio dio, String baseUrl) {
    getIt.registerLazySingleton<HomeDataSource>(
        () => HomeDataSource(dio, baseUrl: baseUrl));
  }

  static _injectNetworkingDependencies() {
    final dio = _injectDio();
    final baseUrl = dotenv.get(DotenvKeys.baseUrl);
    _injectApiServices(dio, baseUrl);
  }
}
