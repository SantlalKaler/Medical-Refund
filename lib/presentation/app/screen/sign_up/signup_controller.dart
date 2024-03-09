import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CommonModel.dart';
import 'package:lab_test_app/presentation/base/constant.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../data/api.dart';
import '../../../../data/response_status.dart';
import '../../../../domain/model/auth/VerifyOtp.dart';
import '../../../base/pref_data.dart';
import '../../routes/app_routes.dart';

class SignupController extends GetxController {
  API api = API();
  RxBool agreeTerm = true.obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final referralCodeController = TextEditingController().obs;

  RxBool loading = false.obs;

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  isAgree() {
    agreeTerm.value = !agreeTerm.value;
    update();
  }

  validate() {
    if (phoneController.value.text.length < 10) {
      showSnackbar("Alert", "Enter Valid phone number");
    } else if (!agreeTerm.value) {
      showSnackbar("Alert", "Please accept terms and conditions");
    } else {
      registerUser();
    }
  }

  registerUser() async {
    isLoading();
    String? fcmToken;
    fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((value) {
      fcmToken = value;
    }).onError((err) {});

    var response =
        CommonModel.fromJson(await api.postRequest(AppUrls.register, {
      "name": nameController.value.text,
      "mobile": phoneController.value.text,
      "ref": referralCodeController.value.text,
      "deviceToken": fcmToken,
      "deviceType": Platform.operatingSystem
    }));

    showSnackbar("Message", response.message);
    isLoading();

    if (response.status == Status.success.name) {
      Constant.moveToNext(Routes.verificationRoute);
    }
  }

  Future<bool> verifyOtp(String otp) async {
    bool verify = false;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    if (otp.length < 4) {
      showSnackbar("Alert", "Enter valid OTP");
    } else {
      isLoading();
      var response = await api.postRequest(AppUrls.verifyOtp, {
        "mobile": phoneController.value.text,
        "otp": otp,
      });
      isLoading();
      showSnackbar("Message", response['message']);
      var verifyOtp = VerifyOtp.fromJson(response);

      if (verifyOtp.status == Status.success.name) {
        PrefData.setIsSignIn(true);
        PrefData.saveUser(jsonEncode(verifyOtp.user));
        Constant.moveToNextAndReplace(Routes.homeScreenRoute);

        //save data to firebase firestore
        var user = verifyOtp.user!;
        await fireStore
            .collection(Constant.firebaseUserCollection)
            .doc(user.id)
            .set({
          "id": user.id,
          "name": user.name,
          "email": user.email,
          "phone": user.mobile,
          "status": "Online",
        });
      }
    }
    return verify;
  }

/*Future<User> createFirebaseAccount()async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      User user = await _auth.c
    }catch(e){

    }
  }*/
}
