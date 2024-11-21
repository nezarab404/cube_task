import 'package:bot_toast/bot_toast.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../di/app_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';

import 'fallback_screen.dart';
import 'routes_paths.dart';
import '../utils/observers/custom_navigation_observer.dart';

class AppRouter {
  final GoRouter goRouter;

  static late AppRouter _appRouter;

  static init() {
    _appRouter = AppRouter();
  }

  AppRouter() : goRouter = _getRouter;

  static get getRouter => _appRouter.goRouter;

  static get _getRouter => GoRouter(
        initialLocation: RoutesPaths.home,
        observers: [BotToastNavigatorObserver(), CustomNavigationObserver()],
        errorBuilder: (context, state) => const FallbackScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: RoutesPaths.home,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider<HomeCubit>(
                create: (context) => getIt.get<HomeCubit>(),
                child: const HomeScreen(),
              );
            },
          ),
        ],
      );


  static bool canPop() => getRouter.canPop();

  static Future<T?> push<T extends Object?>(String location, {Object? extra}) =>
      getRouter.push<T>(location, extra: extra);

  static Future<T?> pushReplacement<T extends Object?>(String location,
      {Object? extra}) =>
      getRouter.pushReplacement<T>(location, extra: extra);

  static go(String location, {Object? extra}) =>
      getRouter.go(location, extra: extra);

  static pop<T extends Object?>([T? result]) => getRouter.pop<T?>(result);

}

extension GoRouterPopUntil on GoRouter {
  void popUntil(String routePath) {
    List routeStacks = [...routerDelegate.currentConfiguration.routes];
    for (int i = routeStacks.length - 1; i >= 0; i--) {
      RouteBase route = routeStacks[i];
      if (route is GoRoute) {
        if (route.path == routePath) break;
        if (i != 0 && routeStacks[i - 1] is ShellRoute) {
          RouteMatchList matchList = routerDelegate.currentConfiguration;
          restore(matchList.remove(matchList.matches.last));
        } else {
          pop();
        }
      }
    }
  }
}
