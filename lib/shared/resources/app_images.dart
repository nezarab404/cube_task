abstract final class AppImages {
  static String fallback = 'im_fallback.svg'.imageAssetsPath;
}

extension _ImagesPath on String {
  String get imageAssetsPath => 'assets/images/$this';
}
