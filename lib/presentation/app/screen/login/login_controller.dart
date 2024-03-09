import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/api.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CommonModel.dart';
import 'package:lab_test_app/domain/model/auth/VerifyOtp.dart';
import 'package:lab_test_app/domain/model/auth/VerifyOtpSpecialist.dart';
import 'package:lab_test_app/presentation/app/screen/home/home_screen.dart';
import 'package:lab_test_app/presentation/app/screen/home/home_screen_specialist.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../data/response_status.dart';
import '../../../../domain/model/CityModel.dart';
import '../../../../domain/model/SettingModel.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  var settings = Rxn<SettingModel>();
  var cities = Rxn<CityModel>();
  API api = API();
  final mobileController = TextEditingController().obs;
  final otpController = TextEditingController().obs;
  RxBool otpEnable = false.obs;
  RxBool isResend = false.obs;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  RxBool loading = false.obs;
  RxString btnTxt = "Get Otp".obs;
  RxBool isSpecialist = false.obs;

  changeUserType() {
    isSpecialist.value = !isSpecialist.value;
    update();
  }

  changeBtnTxt(text) {
    btnTxt.value = text;
    update();
  }

  isEnable() {
    otpController.value.text = "";
    otpEnable.value = !otpEnable.value;
    update();
  }

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  getCities() async {
    var res = await api.getRequestWithoutData(AppUrls.city);

    isLoading();
    cities.value = CityModel.fromJson(res);
    if (cities.value?.status == Status.success.name) {
      PrefData.saveCities(jsonEncode(cities.value));
      var defaultCity = await PrefData.getDefaultCity();
      if (cities.value!.result!.isNotEmpty && defaultCity == null) {
        PrefData.setDefaultCity(jsonEncode(cities.value!.result![0]));
      }
    }
    update();
  }

  getSettings() async {
    isLoading();
    var res = await api.getRequest(AppUrls.settings, {"": ""});
    settings.value = SettingModel.fromJson(res);
    if (settings.value?.status == Status.success.name) {
      PrefData.saveSettings(jsonEncode(settings.value));
      if (!await PrefData.getIsSpecialist()) {
        getCities();
      }
    }
    update();
  }

  void getToken() async {
    String? token = await messaging.getToken();
    PrefData.saveToken(token!);
    getSettings();
    print('Device Token: $token');
  }

  validate() async {
    if (mobileController.value.text.isEmpty ||
        mobileController.value.text.length < 10) {
      showSnackbar("Alert", "Enter Valid Mobile Number");
    } else if (btnTxt.value == "Get Otp") {
      isResend.value=false;
      await getOtp();
    } else {
      verifyOtp();
    }
  }

  getOtp() async {
    isLoading();
    var deviceType = Platform.isAndroid ? "Android" : 'Ios';
    var token = await PrefData.getToken();
    var response = CommonModel.fromJson(await api.postRequest(
        !isSpecialist.value ? AppUrls.getOtp : AppUrls.getOtpSpecialist, {
      "mobile": mobileController.value.text,
      "deviceToken": token,
      "deviceType": deviceType
    }));

    showSnackbar("Message", response.message);

    if (response.status == Status.success.name) {
      isEnable();
      changeBtnTxt("Login");
    }
    isLoading();

    //print("Response in login controller : ${response.message}");
  }

  verifyOtp() async {
    isLoading();
    var response = await api.postRequest(
        !isSpecialist.value ? AppUrls.verifyOtp : AppUrls.verifyOtpSpecialist, {
      "mobile": mobileController.value.text,
      "otp": otpController.value.text,
    });
    isLoading();
    showSnackbar("Message", response['message']);

    Constant.printValue(response);

    if (response['status'] == Status.success.name) {
      PrefData.setIsSignIn(true);
      PrefData.setIsSpecialist(isSpecialist.value);

      if (isSpecialist.value) {
        var verifyOtp = VerifyOtpSpecialist.fromJson(response);
        PrefData.saveUserSpecialist(jsonEncode(verifyOtp.specialist));
      } else {
        var verifyOtp = VerifyOtp.fromJson(response);
        PrefData.saveUser(jsonEncode(verifyOtp.user));
      }
      if (isSpecialist.value) {
        Get.offAll(const HomeScreenSpecialist());
      } else {
        Get.offAll(const HomeScreen());
      }

      Constant.moveToNextAndReplace(isSpecialist.value
          ? Routes.homeSpecialistScreenRoute
          : Routes.homeScreenRoute);
    }
  }
}
