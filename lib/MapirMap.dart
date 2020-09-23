import 'dart:io';

import 'package:device_info/device_info.dart';

class MapirMap {
  static String apiKey = "";
  static MapirMap instance;
  String userAgent = "";

  static MapirMap init(packageName, apiKey) {
    if (instance == null)
      return MapirMap(packageName, apiKey);
    else
      return instance;
  }

  MapirMap(packageName, _apiKey) {
    apiKey = _apiKey;
    userAgent = userAgentString(packageName);
  }

  String userAgentString(packageName) {
    if (Platform.isAndroid) {
      var androidInfo = DeviceInfoPlugin().androidInfo;
      return toHumanReadableAscii("Android/"
          //     "${androidInfo.version.sdkInt}"
          //     "(${androidInfo.version.release})"
          //     "(${androidInfo.supportedAbis})"
          "-FlutterSdk/"
          "0.0.1-"
          "$packageName");
    } else if (Platform.isIOS) {
      var iosInfo = DeviceInfoPlugin().iosInfo;
      return toHumanReadableAscii("Ios/"
          //       "${iosInfo.utsname.version}"
          //       "(${iosInfo.utsname.release})"
          //       "(${iosInfo.utsname.machine})-"
          "FlutterSdk/"
          "0.0.1-"
          "$packageName");
    } else
      return "Neither Android Nor Ios";
  }

  static String toHumanReadableAscii(String s) {
    return s;
  }
}
