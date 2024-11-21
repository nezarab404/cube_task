import '../data/local/cache_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/observers/custom_bloc_observer.dart';
import 'app_di.dart';
import '../routing/router.dart';

abstract class AppInitializer {
  static init() async {
    ///because binding should be initialized before calling runApp.
    WidgetsFlutterBinding.ensureInitialized();

    /// observing on create ,edit and delete cubits
    Bloc.observer = CustomBlocObserver();

    /// loading .env file
    await dotenv.load(fileName: '.env');

    ///initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    ///initialize routing
    AppRouter.init();

    ///dependencies injection
    await AppDI.setup();

    ///initialize caching
    CacheManager.init();

    ///initialize ScreenUtil
    await ScreenUtil.ensureScreenSize();
  }
}
