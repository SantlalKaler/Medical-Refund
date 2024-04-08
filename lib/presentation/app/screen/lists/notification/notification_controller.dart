import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/NotificationModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../../../data/api.dart';

class NotificationController extends GetxController {
  var notifications = Rxn<NotificationModel>();
  RxList<Result> notificationList = RxList();
  var user = Rxn<User>();
  RxInt selectedNotification = 0.obs;

  RxBool loading = false.obs;
  RxBool anyUnreadNotification = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
    await getNotifications();
  }

  getNotifications() async {
    try {
      setLoading();

      var res =
          await api.getRequest(AppUrls.notifications, {"id": user.value?.id});
      notifications.value = NotificationModel.fromJson(res);
      if (notifications.value != null &&
          notifications.value!.result != null &&
          notifications.value!.result!.isNotEmpty) {
        for (var notification in notifications.value!.result!) {
          if (!notification.read!) {
            anyUnreadNotification.value = true;
            break;
          }
        }
      }
      update();
    } finally {
      setLoading();
      update();
    }
  }

  readNotification() async {
    try {
      var res = await api.postRequest(AppUrls.readNotification,
          {"id": notifications.value!.result![selectedNotification.value]});
      if (res['status'] == "success") {
        getNotifications();
      }
    } finally {}
  }
}
