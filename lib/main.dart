import 'shared/base_app.dart';
import 'shared/di/app_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInitializer.init();
  runApp(const BaseApp());
}
