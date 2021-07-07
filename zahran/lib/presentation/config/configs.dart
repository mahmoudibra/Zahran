class BuildConfigs {
  static const String _stgUrlPrefix = "https://pencilprod.com/zahran";
  static const String _betaUrlPrefix = "https://pencilprod.com/zahran";

  static const String BASE_URL_PREFIX = BuildConfigs._betaUrlPrefix;
  static bool isLiveBuild() =>
      BASE_URL_PREFIX == _betaUrlPrefix && BASE_URL_PREFIX != _stgUrlPrefix;
}

class GeneralConfigs {
  static const String BASE_URL = BuildConfigs.BASE_URL_PREFIX + "/dev/api";
  static const String OPS_DASHBOARD_BASE_URL =
      BuildConfigs.BASE_URL_PREFIX + "/ops/";
  static const String IMAGE_ASSETS_PATH = "assets/images/";
  static const String LOCALIZATION_PATH = "assets/localization/";
  static const String ANIMATION_PATH = "assets/animations/";
  static const String SVG_PATH = "assets/svg/";
}
