
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/MyNetworkModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../../../data/api.dart';

class NetworkController extends GetxController {
  var user = Rxn<User>();
  var networks = Rxn<MyNetworkModel>();

  RxBool loading = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
    getNetworks();
  }

  getNetworks() async {
    setLoading();
    var res = await api.getRequest(AppUrls.myNetwork, {
      'id':user.value!.id!
    });
    networks.value = MyNetworkModel.fromJson(res);
    setLoading();
    update();

  }
}
