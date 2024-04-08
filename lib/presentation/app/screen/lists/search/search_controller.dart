import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/api.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lab_test_app/domain/model/CityModel.dart' as ct;
import 'package:lab_test_app/domain/model/SpecialistSearchModel.dart';
import 'package:lab_test_app/domain/model/TestSearchModel.dart';
import 'package:lab_test_app/presentation/app/screen/common/lab_list_view.dart';
import 'package:lab_test_app/presentation/base/constant.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../domain/model/LabSearchModel.dart';

class SearcController extends GetxController {
  RxBool loading = false.obs;
  API api = API();
  var labSearch = Rxn<LabSearchModel>();
  var defaultCity = Rxn<ct.Result>();
  var specialistSearch = Rxn<SpecialistSearchModel>();
  var testSearch = Rxn<TestSearchModel>();
  var searchData = Rxn<List<SearchData>>();
  final searchController = TextEditingController().obs;
  RxString searchByValue = "".obs;
  String lat = '22.5913113';
  String lng = '88.4234245';

  List<String> searchByList = [];

  getSearchByList(BuildContext context) {
    searchByList = [
      AppLocalizations.of(context)!.lab,
      AppLocalizations.of(context)!.specialist,
      AppLocalizations.of(context)!.test
    ];
    searchByValue.value = searchByList[0];
  }

  @override
  void onInit() {
    getDefaultCity();
    super.onInit();
  }

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  getDefaultCity() async {
    defaultCity.value = await PrefData.getDefaultCity();
    update();
  }

  changeSearchByValue(value) {
    searchByValue.value = value;
    Constant.printValue("Search by value : ${searchByValue.value}");
    update();
  }

  validate() {
    Constant.printValue("Search by value : ${searchByValue.value}");
    if (searchByValue.value == searchByList[0]) {
      searchLab();
    } else if (searchByValue.value == searchByList[1]) {
      searchSpecialist();
    } else {
      searchTest();
    }
  }

  searchLab() async {
    await getDefaultCity();
    isLoading();
    var res = await api.getRequest(AppUrls.labSearch, {
      /* "lat": lat,
      "lng": lng,*/
      "query": searchController.value.text.trim(),
      "city": defaultCity.value!.id!
    });

    isLoading();
    labSearch.value = LabSearchModel.fromJson(res);

    if (labSearch.value!.result!.isEmpty) {
      showSnackbar("Message", "No Lab found");
    } else {
      searchData.value = labSearch.value!.result!
          .map((e) => SearchData(e.id!, e.image!, e.name!, e.officeAddress!))
          .toList();
    }
    update();
  }

  searchSpecialist() async {
    isLoading();
    var res = await api.getRequest(AppUrls.specialistSearch, {
      /*  "lat": lat,
      "lng": lng,*/
      "query": searchController.value.text.trim(),
      "city": defaultCity.value!.id!
    });
    isLoading();
    specialistSearch.value = SpecialistSearchModel.fromJson(res);

    if (specialistSearch.value!.result!.isEmpty) {
      showSnackbar("Message", "No Specialist found");
    } else {
      searchData.value = specialistSearch.value!.result!
          .map((e) => SearchData(e.id!, e.image!, e.name!, e.education!))
          .toList();
    }
  }

  searchTest() async {
    isLoading();
    var res = await api.getRequest(AppUrls.testSearch, {
      /* "lat": lat,
      "lng": lng,*/
      "query": searchController.value.text.trim(),
      "city": defaultCity.value!.id!
    });
    isLoading();
    testSearch.value = TestSearchModel.fromJson(res);

    if (testSearch.value!.result!.isEmpty) {
      showSnackbar("Message", "No Test found");
    } else {
      searchData.value = testSearch.value!.result!
          .map((e) => SearchData(e.id!, e.image!, e.title!, e.shortDesc!))
          .toList();
    }
  }
}
