import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/NotificationModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../../../data/api.dart';

class NotificationController extends GetxController {
  var notifications = Rxn<NotificationModel>();
  var user = Rxn<User>();

  RxBool loading = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
    getNotifications();
  }


  getNotifications() async {
    setLoading();
    var res = await api.getRequest(AppUrls.notifications, {
      "id": user.value?.id,
      "pageNumber": '1',
      "pageSize": '20'
    });
    setLoading();
    notifications.value = NotificationModel.fromJson(res);
    update();
  }
}
