import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/SpecialistDetailsModel.dart';

import '../../../../../data/api.dart';
import '../../../../../data/response_status.dart';
import '../../../../base/constant.dart';
import '../../../../base/view_utils.dart';

class SpecialistController extends GetxController {
  var specialistDetails = Rxn<SpecialistDetailsModel>();

  RxBool loading = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getSpecialistDetails(String specialistId) async {
    setLoading();
    var res =
        await api.getRequest(AppUrls.specialistDetail, {"id": specialistId});

    setLoading();

    specialistDetails.value = SpecialistDetailsModel.fromJson(res);
    update();
    if (specialistDetails.value!.status == Status.success.name) {
    } else {
      showSnackbar("Message", "Something went wrong. Try again later");
      Constant.backToPrev();
    }
  }
}
