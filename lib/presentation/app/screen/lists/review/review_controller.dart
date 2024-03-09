import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CommonModel.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/domain/model/review.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../data/api.dart';
import '../../../../../domain/model/BookingModel.dart';
import '../../../../../domain/model/SpecialistDetailsModel.dart';
import '../../../../../domain/model/auth/user.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';

class ReviewController extends GetxController {
  List<Reviews> reviewList = [];
  var bookingResponse = Rxn<BookingModel>();
  var labDetails = Rxn<LabDetailsModel>();
  var specialistDetails = Rxn<SpecialistDetailsModel>();
  final user = Rxn<User>();
  var reviewMessage = TextEditingController().obs;

  RxBool loading = false.obs;
  Map reviewOf = {};
  double rating = 2;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
  }

  getDetails() {
    if (reviewOf.containsKey('lab')) {
      getLabDetails(reviewOf['lab']);
    } else {
      getSpecialistDetails(reviewOf['specialist']);
    }
  }

  getLabDetails(String labId) async {
    setLoading();
    var res = await api.getRequest(AppUrls.labDetails, {"id": labId});
    setLoading();
    labDetails.value = LabDetailsModel.fromJson(res);
    reviewList = labDetails.value!.result!.reviews!;
    update();
  }

  getSpecialistDetails(String specialistId) async {
    setLoading();
    var res =
        await api.getRequest(AppUrls.specialistDetail, {"id": specialistId});

    setLoading();
    specialistDetails.value = SpecialistDetailsModel.fromJson(res);
    reviewList = specialistDetails.value!.result!.reviews!;
    update();
  }

  getBookings() async {
    setLoading();
    var res = await api.getRequest(AppUrls.myBookings, {"id": user.value!.id});
    bookingResponse.value = BookingModel.fromJson(res);
    setLoading();

    if (isEligibleForeReview()) {
      addReview();
    } else {
      showSnackbar('Message', 'To review first you have to use our service');
    }

    update();
  }

  bool isEligibleForeReview() {
    if (reviewOf.containsKey('lab')) {
      var labId = labDetails.value!.result!.detail!.id;
      for (var result in bookingResponse.value!.result!) {
        var lab = result.labs;
        if (lab != null) {
          Constant.printValue(
              "Book lab id : ${lab.id}\n Review lab Id : $labId");
          if (lab.id == labId) {
            return true;
          }
        }
      }
    } else {
      var specialistId = specialistDetails.value!.result!.detail!.id;
      for (var result in bookingResponse.value!.result!) {
        var specialist = result.specialist;
        if (specialist != null) {
          Constant.printValue(
              "Book lab id : ${specialist.id}\n Review lab Id : $specialistId");
          if (specialist.id == specialistId) {
            return true;
          }
        }
      }
    }
    return false;
  }

  addReview() async {
    setLoading();
    var id = reviewOf.containsKey('lab')
        ? labDetails.value!.result!.detail!.id!
        : specialistDetails.value!.result!.detail!.id!;

    var reviewAbout = reviewOf.containsKey('lab') ? 'lab' : 'specialist';
    var res = await api.postRequest(
        reviewOf.containsKey('lab')
            ? AppUrls.addLabReview
            : AppUrls.addSpecialistReview,
        {
          reviewAbout: id,
          'user': user.value!.id,
          'rating': rating,
          'message': reviewMessage.value.text
        });

    var commonResponse = CommonModel.fromJson(res);

    reviewMessage.value.text = '';

    setLoading();
    showSnackbar('Message', commonResponse.message);
    update();
  }
}
