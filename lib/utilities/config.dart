import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

@immutable
class Config {
  bool get isDebugging => !kReleaseMode;

  Future<String> getPlatform() async {
    if (GetPlatform.isWeb) {
      return 'web';
    } else if (GetPlatform.isAndroid) {
      return 'android';
    } else if (GetPlatform.isIOS) {
      return 'ios';
    } else {
      return 'unknown';
    }
  }

  // Future<bool> isRooted() async {
  //   final bool isRooted = await FlutterJailbreakDetection.jailbroken;
  //   const bool isDebugging = !kReleaseMode;

  //   if (isDebugging) {
  //     debugPrint('Device is rooted?  $isRooted');
  //     if (isRooted) debugPrint('Ignoring root: developer mode detected');
  //     return false;
  //   }

  //   return isRooted;
  // }

  // Future<Map<String, bool>> getDeviceState() async {
  //   final bool isRooted = await FlutterJailbreakDetection.jailbroken;
  //   final bool developerMode = await FlutterJailbreakDetection.developerMode;

  //   return <String, bool>{
  //     'isRooted': isRooted,
  //     'isDeveloperMode': developerMode
  //   };
  // }
}
