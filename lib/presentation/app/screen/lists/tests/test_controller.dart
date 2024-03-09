import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CityModel.dart' as ct;
import 'package:lab_test_app/domain/model/TestDetailModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../../../data/api.dart';

class TestController extends GetxController {
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();

  var user = Rxn<User>();
  var defaultCity = Rxn<ct.Result>();

  var testDetails = Rxn<TestDetailModel>();

  var specialist = Rxn<Specialist>();

  RxBool loading = false.obs;
  API api = API();

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
  }

  getDefaultCity() async {
    defaultCity.value = await PrefData.getDefaultCity();
    update();
  }

  getTest(testId) async {
    await getDefaultCity();
    setLoading();
    var res = await api.getRequest(AppUrls.testDetail, {
      'id': testId,
      'city':
          defaultCity.value!.id! /* 'lat': '22.5913113', 'lng': '88.4234245'*/
    });
    setLoading();
    testDetails.value = TestDetailModel.fromJson(res);
    update();
  }
}
