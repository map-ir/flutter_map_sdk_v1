class MapirMap {
  static String apiKey = "";
  static MapirMap instance;
  String userAgent = "";

  String get apikey => apiKey;

  static MapirMap init(context, apiKey) {
    if (instance == null)
      return MapirMap(context, apiKey);
    else
      return instance;
  }

  MapirMap(context, _apiKey) {
    apiKey = _apiKey;
    userAgent = userAgentString(context);
  }

  String userAgentString(context) {
    // if (Platform.isAndroid) {
    //   var androidInfo = DeviceInfoPlugin().androidInfo;
    //   return toHumanReadableAscii("Android/"
    //       "${androidInfo.version.sdkInt}"
    //       "(${androidInfo.version.release})"
    //       "(${androidInfo.supportedAbis})-FlutterSdk/"
    //       "22222222-"
    //       "${context.getPackageName()}");
    // } else if (Platform.isIOS) {
    //   var iosInfo = DeviceInfoPlugin().iosInfo;
    //
    //   return toHumanReadableAscii("Ios/"
    //       "${iosInfo.utsname.version}"
    //       "(${iosInfo.utsname.release})"
    //       "(${iosInfo.utsname.machine})-FlutterSdk/"
    //       "222222222-"
    //       "${context.getPackageName()}");
    // } else
    return "Neither Android Nor Ios";
  }

  static String toHumanReadableAscii(String s) {
    return s;
  }
}
