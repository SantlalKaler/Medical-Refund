import 'dart:convert';

import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CityModel.dart';
import 'package:lab_test_app/domain/model/SettingModel.dart';
import 'package:lab_test_app/presentation/base/locals.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../../../data/api.dart';
import '../../../data/response_status.dart';
import '../../../domain/model/ListPageModel.dart';
import '../../base/constant.dart';
import '../routes/app_routes.dart';

class SettingController extends GetxController {
  var settings = Rxn<SettingModel>();
  var pages = Rxn<ListPageModel>();
  var cities = Rxn<CityModel>();

  RxBool loading = false.obs;
  API api = API();
  RxInt page = 0.obs;

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  saveLocale() async{
    var locale = await PrefData.getLocale();
    Constant.printValue("Locale : ${locale}");
    Get.updateLocale(locale == "0" ? AppLocals.english : locale == "1"
        ? AppLocals.hindi
        : AppLocals.punjabi);
  }

  getSettings() async {
    saveLocale();
    setLoading();
    var res = await api.getRequest(AppUrls.settings, {"": ""});
    settings.value = SettingModel.fromJson(res);
    if (settings.value?.status == Status.success.name) {
      PrefData.saveSettings(jsonEncode(settings.value));
      if (!await PrefData.getIsSpecialist()) {
        getCities();
      } else {
        getIntro();
      }
    }
    update();
  }

  getSettingsFromLocalStorage() async {
    setLoading();
    settings.value = await PrefData.getSettings();
    update();
    setLoading();
  }

  getCities() async {
    var res = await api.getRequestWithoutData(AppUrls.city);

    setLoading();
    cities.value = CityModel.fromJson(res);
    if (cities.value?.status == Status.success.name) {
      PrefData.saveCities(jsonEncode(cities.value));
      var defaultCity = await PrefData.getDefaultCity();
      if (cities.value!.result!.isNotEmpty && defaultCity == null) {
        PrefData.setDefaultCity(jsonEncode(cities.value!.result![0]));
      }
      getIntro();
    }
    update();
  }

  getIntro() async {
    bool isIntro = await PrefData.getIsIntro();
    bool isLogin = await PrefData.getIsSignIn();
    bool isSpecialist = await PrefData.getIsSpecialist();
    Constant.printValue(isLogin);

    /*    if (isIntro) {
          Constant.moveToNext(Routes.introRoute);
        } else {*/

    if (isLogin) {
      Constant.moveToNext(isSpecialist
          ? Routes.homeSpecialistScreenRoute
          : Routes.homeScreenRoute);
    } else {
      //Constant.moveToNext(Routes.loginRoute);
      Constant.moveToNext(isIntro ? Routes.introRoute : Routes.loginRoute);
    }
  }

  getPageList() async {
    setLoading();
    var res = await api.getRequestWithoutData(AppUrls.listPage);
    pages.value = ListPageModel.fromJson(res);
    setLoading();
    update();
  }
}
