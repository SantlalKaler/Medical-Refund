import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/domain/model/Lab.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../data/api.dart';
import '../../../../base/constant.dart';

class LabController extends GetxController {
  var labDetails = Rxn<LabDetailsModel>();
  var lab = Rxn<Lab>();
  var labWithTestData = Rxn<LabDetailsModel>();
  var image = Rxn<String>();
  var lat = Rxn<double>();
  var lng = Rxn<double>();
  RxList<Tests> tests = <Tests>[].obs;

  RxBool loading = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getLabDetails(String labId) async {
    tests.clear();
    setLoading();
    var res = await api.getRequest(AppUrls.labDetails, {"id": labId});

    setLoading();
    labDetails.value = LabDetailsModel.fromJson(res);
    if (labDetails.value!.status == Status.success.name) {
      lab.value = labDetails.value!.result!.detail;
      image.value = "${AppUrls.imageBaseUrl}${lab.value!.image}";
      lat.value = lab.value!.position!.coordinates!.first.toDouble();
      lng.value = lab.value!.position!.coordinates!.last.toDouble();
      for (var element in labDetails.value!.result!.tests!) {
        tests.add(element);
      }
      update();

      //saveLabToFirebase();

      Constant.printValue("${lat.value}\n${lng.value}");
    } else {
      showSnackbar("Message", "Something went wrong. Try again later");
      Constant.backToPrev();
    }
  }

  getLabWithSingleTest(labId, testId) async {
    try {
      tests.clear();
      setLoading();
      var res = await api
          .getRequest(AppUrls.labWithTest, {"id": labId, "test": testId});

      labDetails.value = LabDetailsModel.fromJson(res);
      if (labDetails.value!.status == Status.success.name) {
        labWithTestData.value = labDetails.value!;
        update();
      } else {
        showSnackbar("Message", "Something went wrong. Try again later");
        Constant.backToPrev();
      }
    } finally {
      setLoading();
    }
  }

  saveLabToFirebase() async {
    var labD = lab.value!;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    await fireStore
        .collection(Constant.firebaseLabCollection)
        .doc(labD.id)
        .set({
      "id": labD.id,
      "name": labD.name,
      "email": labD.email,
      "phone": labD.officeAddress,
      "image": image.value!,
      "status": "Online",
    });
  }
}
