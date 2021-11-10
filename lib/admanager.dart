import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5244380836127327~3828975975";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5244380836127327~8666806393";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5244380836127327/5449450845";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5244380836127327/2890707867";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5244380836127327/5091531658";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5244380836127327/7979093374";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5244380836127327/3755205153";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5244380836127327/6115637004";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}
