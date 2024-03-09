import 'dart:convert';

import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/domain/model/CityModel.dart' as ct;
import 'package:lab_test_app/domain/model/SettingModel.dart' as st;
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../data/api.dart';
import '../../../../domain/model/HomeModel.dart';
import '../../../../domain/model/auth/user.dart';
import '../../../base/constant.dart';
import '../common/lab_list_view.dart';

class HomeController extends GetxController {
  final user = Rxn<User>();
  final specialist = Rxn<Specialist>();
  RxBool isSpecialist = false.obs;
  final settings = Rxn<st.SettingModel>();
  final cities = Rxn<ct.CityModel>();
  final defaultCity = Rxn<ct.Result>();
  var homeData = Rxn<Result>();
  var searchData = Rxn<List<SearchData>>();

  @override
  void onInit() {
    getCities();
    getSettings();
    getUser();
    getHome();
    super.onInit();
  }

  API api = API();
  RxBool loading = false.obs;

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  getHome() async {
    await getDefaultCity();
    isLoading();
    var res =
        await api.getRequest(AppUrls.home, {'city': defaultCity.value!.id!});
    isLoading();
    var homeModel = HomeModel.fromJson(res);
    if (homeModel.status == Status.success.name) {
      homeData.value = homeModel.result;

      searchData.value = homeData.value!.labs!
          .map((e) => SearchData(e.id!, e.image!, e.name!, e.officeAddress!))
          .toList();
    } else {
      showSnackbar("Alert", "Something is wrong");
    }
  }

  getUser() async {
    isLoading();
    isSpecialist.value = await PrefData.getIsSpecialist();

    if (isSpecialist.value) {
      specialist.value = await PrefData.getUserSpecialist();
      Constant.printValue(specialist.value);
    } else {
      user.value = await PrefData.getUser();
      Constant.printValue(user.value);
    }
    isLoading();
    update();
  }

  getSettings() async {
    isLoading();
    settings.value = await PrefData.getSettings();
    isLoading();
    update();
  }

  getCities() async {
    isLoading();
    cities.value = await PrefData.getCities();
    isLoading();
    update();
  }

  getDefaultCity() async {
    isLoading();
    defaultCity.value = await PrefData.getDefaultCity();
    isLoading();
    update();
  }

  setDefaultCity(String value) {
    isLoading();
    for (var city in cities.value!.result!) {
      if (city.name == value) {
        PrefData.setDefaultCity(jsonEncode(city));
        getHome();
      }
    }
    isLoading();
  }
}
