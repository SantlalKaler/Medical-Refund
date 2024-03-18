import 'dart:convert';

import 'package:lab_test_app/domain/model/CityModel.dart' as ct;
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/SettingModel.dart';
import '../../domain/model/auth/user.dart';
import 'constant.dart';

class PrefData {
  static String prefName = "com.example.learn_management_app_ui";

  static String isIntro = "${prefName}isIntro";
  static String inSignIn = "${prefName}isSignIn";
  static String isSpecialist = "isSpecialist";
  static String user = "user";
  static String userSpecialist = "userSpecialist";
  static String settings = "settings";
  static String cities = "cities";
  static String defaultCity = "defaultCity";
  static String token = "token";
  static String userType = "userType";

  static setIsIntro(bool sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isIntro, sizes);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool intValue = prefs.getBool(isIntro) ?? true;
    return intValue;
  }

  static getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(inSignIn) ?? false;
  }

  static setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(inSignIn, isFav);
  }

  static clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static setIsSpecialist(bool value) async {
    Constant.printValue("is Specialist : $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isSpecialist, value);
    getIsSpecialist();
  }

  static Future<bool> getIsSpecialist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userTypeValue = prefs.getBool(isSpecialist) ?? false;
    Constant.printValue("User Type is specialist: $userTypeValue");
    return userTypeValue;
  }

  static saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenValue = prefs.getString(token) ?? '';
    Constant.printValue("Token is : $tokenValue");
    return tokenValue;
  }

  static saveUser(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(jsonString);
    String userInfo = jsonEncode(User.fromJson(decodeOptions));
    prefs.setString(user, userInfo);
    await getUser();
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString(user) ?? '';

    if (userInfo.isNotEmpty) {
      Map userMap = jsonDecode(userInfo);
      var user = User.fromJson(userMap);
    Constant.printValue("Fetch user customer successfully -> \n\n$userInfo\n\n"
        "User is ${user.panNumber}");
      return user;
    }
    return null;
  }

  static saveUserSpecialist(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(jsonString);
    String userInfo = jsonEncode(Specialist.fromJson(decodeOptions));
    prefs.setString(userSpecialist, userInfo);
    await getUserSpecialist();
  }

  static Future<Specialist?> getUserSpecialist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString(userSpecialist) ?? '';
    Constant.printValue("Fetch user specialist successfully -> \n\n$userInfo");

    if (userInfo.isNotEmpty) {
      Map userMap = jsonDecode(userInfo);
      var user = Specialist.fromJson(userMap);
      return user;
    }
    return null;
  }

  static saveSettings(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(jsonString);
    String settingInfo = jsonEncode(SettingModel.fromJson(decodeOptions));
    prefs.setString(settings, settingInfo);
    await getSettings();
  }

  static saveCities(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(jsonString);
    String cityInfo = jsonEncode(ct.CityModel.fromJson(decodeOptions));
    prefs.setString(cities, cityInfo);
    await getCities();
  }

  static Future<ct.CityModel?> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cityInfo = prefs.getString(cities) ?? '';
    print("Fetch city successfully -> \n\n$cityInfo");

    if (cityInfo.isNotEmpty) {
      Map settingMap = jsonDecode(cityInfo);
      var cityList = ct.CityModel.fromJson(settingMap);
      return cityList;
    }
    return null;
  }

  static setDefaultCity(String jsonString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(jsonString);
    String cityInfo = jsonEncode(ct.Result.fromJson(decodeOptions));
    prefs.setString(defaultCity, cityInfo);
  }

  static Future<ct.Result?> getDefaultCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cityInfo = prefs.getString(defaultCity) ?? '';
    print("Fetch default city successfully -> \n\n$cityInfo");

    if (cityInfo.isNotEmpty) {
      Map settingMap = jsonDecode(cityInfo);
      var defaultCity = ct.Result.fromJson(settingMap);
      return defaultCity;
    }
    return null;
  }

  static Future<SettingModel?> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var settingInfo = prefs.getString(settings) ?? '';
    print("Fetch setting successfully -> \n\n$settingInfo");

    if (settingInfo.isNotEmpty) {
      Map settingMap = jsonDecode(settingInfo);
      var settings = SettingModel.fromJson(settingMap);
      return settings;
    }
    return null;
  }
}
