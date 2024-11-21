abstract final class AppIcons {
  static String home = 'home.svg'.iconAssetsPath;
}

extension _IconsPath on String {
  String get iconAssetsPath => 'assets/icons/$this';
}
