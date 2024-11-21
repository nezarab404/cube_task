abstract final class AppImages {
  static String hello = 'hello.png'.imageAssetsPath;
}

extension _ImagesPath on String {
  String get imageAssetsPath => 'assets/images/$this';
}
