import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPrefsKeys.dart';

class MemoryManagement {
  static SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static void setAccessToken({@required String accessToken}) {
    prefs.setString(SharedPrefsKeys.ACCESS_TOKEN, accessToken);
  }

  static void setName({@required String name}) {
    prefs.setString(SharedPrefsKeys.NAME, name);
  }

  static String getName() {
    return prefs.getString(SharedPrefsKeys.NAME);
  }

  static String getAccessToken() {
    return prefs.getString(SharedPrefsKeys.ACCESS_TOKEN);
  }

  static void setDeviceId({@required String deviceID}) {
    prefs.setString(SharedPrefsKeys.DEVICE_ID, deviceID);
  }

  static String getDeviceId() {
    return prefs?.getString(SharedPrefsKeys.DEVICE_ID);
  }

//  static void setUserInfo({@required User userInfo}) {
//    var userJson = userInfo.toJson();
//    prefs.setString(SharedPrefsKeys.USER_INFO, jsonEncode(userJson) ?? "");
//  }
//
//  static User getUserInfo() {
//    String userString = prefs.getString(SharedPrefsKeys.USER_INFO);
//
//   return  User.fromJson(jsonDecode(userString));
//  }

  //clear all values from shared preferences
  static void clearMemory() {
    prefs.clear();
    print("Shared Pref cleared ");
  }
}
