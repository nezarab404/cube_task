import 'package:flutter/material.dart';

class CustomNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routingLog('PUSH TO ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routingLog('POP FROM: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routingLog('REMOVE: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _routingLog('REPLACE: $oldRoute WITH $newRoute');
  }

  _routingLog(String message) {
    debugPrint("\x1B[34m[ROUTER] => $message\x1B[0m");
  }
}
