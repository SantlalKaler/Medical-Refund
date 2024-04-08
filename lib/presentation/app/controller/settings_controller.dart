import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/base/locals.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

class SettingsController extends GetxController {
  // this is current selected language id as per api which whill be use in APIs
  RxInt currentLanguageID = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // fetch languages data
    super.onInit();
  }

  void updateAppLanguage(Locale locale) {
    // update app language and current language id for API use
    Get.updateLocale(locale);
    PrefData.saveLocal(locale == AppLocals.english
        ? "0"
        : locale == AppLocals.hindi
            ? "1"
            : "2");
  }
}
