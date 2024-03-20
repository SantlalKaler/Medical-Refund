import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lab_test_app/data/api.dart';
import 'package:lab_test_app/domain/model/UpdateDpModel.dart';
import 'package:lab_test_app/domain/model/UpdateProfileModel.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../data/app_urls.dart';
import '../../../../../data/response_status.dart';
import '../../../../../domain/model/CityModel.dart';
import '../../../../../domain/model/auth/user.dart';
import '../../../../../domain/model/specialist.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import 'package:dio/dio.dart' as dio;
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  API api = API();

  //for edit profile screen
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final panNumberController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final birthController = TextEditingController().obs;
  final educationController = TextEditingController().obs;
  final experienceController = TextEditingController().obs;
  final descController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final priceBeforeController = TextEditingController().obs;
  final totalPatientsController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final bankNameController = TextEditingController().obs;
  final accNumberController = TextEditingController().obs;
  final accHolderNameController = TextEditingController().obs;
  final ifscCodeController = TextEditingController().obs;

  final user = Rxn<User>();
  final city = Rxn<Result>();
  final specialist = Rxn<Specialist>();
  final cities = Rxn<CityModel>();
  RxString profilePicName = "".obs;
  RxString profilePicPath = "".obs;
  RxString panPicName = "".obs;
  RxString panPicPath = "".obs;
  RxBool isSpecialist = false.obs;
  RxBool loading = false.obs;

  setProfilePicNameNPath(name, path) {
    profilePicName.value = name;
    profilePicPath.value = path;
    update();
  }

  setPanPicNameNPath(name, path) {
    panPicName.value = name;
    panPicPath.value = path;
    update();
  }

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    isSpecialist.value = await PrefData.getIsSpecialist();
    if (isSpecialist.value) {
      specialist.value = await PrefData.getUserSpecialist();
      Constant.printValue(specialist.value);
    } else {
      user.value = await PrefData.getUser();
      Constant.printValue(
          "user found and user pan is ${user.value?.panNumber}");
    }
    update();
    fillValue();
  }

  getCities() async {
    isLoading();
    cities.value = await PrefData.getCities();
    isLoading();
    update();
  }

  getCityName(String id) {
    for (Result i in cities.value!.result!) {
      if (i.id == id) {
        city.value = i;
      }
    }
    update();
  }

  updateCity(String name) {
    for (Result i in cities.value!.result!) {
      if (i.name == name) {
        city.value = i;
      }
    }
    update();
  }

  fillValue() {
    if (isSpecialist.value) {
      var userSpecialist = specialist.value!;
      getCityName(userSpecialist.city!);
      nameController.value.text = userSpecialist.name ?? "";
      emailController.value.text = "";
      priceBeforeController.value.text = userSpecialist.priceBefore.toString();
      addressController.value.text = userSpecialist.officeAddress ?? "";
      descController.value.text = userSpecialist.desc ?? "";
      totalPatientsController.value.text = userSpecialist.totalPatients ?? "";
      experienceController.value.text = userSpecialist.expereance ?? "";
      educationController.value.text = userSpecialist.education ?? "";
      priceController.value.text = userSpecialist.price.toString();
    } else {
      nameController.value.text = user.value!.name!;
      emailController.value.text = user.value!.email!;
      phoneController.value.text = user.value!.mobile!;
      panNumberController.value.text = user.value!.panNumber ?? "";
      bankNameController.value.text = user.value!.bankName ?? "";
      accNumberController.value.text = user.value!.accNumber ?? "";
      accHolderNameController.value.text = user.value!.accHolderName ?? "";
      ifscCodeController.value.text = user.value!.ifsc ?? "";
      birthController.value.text =
          Constant.changeDateFormat(user.value!.dobDate!);
    }
    update();
  }

  changeDob(dob) {
    birthController.value.text = Constant.changeDateFormat(dob);
    update();
  }

  validate() {
    if (isSpecialist.value) {
      if (nameController.value.text.isEmpty ||
          emailController.value.text.isEmpty ||
          priceBeforeController.value.text.isEmpty ||
          addressController.value.text.isEmpty ||
          city.value == null ||
          descController.value.text.isEmpty ||
          totalPatientsController.value.text.isEmpty ||
          experienceController.value.text.isEmpty ||
          educationController.value.text.isEmpty ||
          priceController.value.text.isEmpty) {
        showSnackbar("Alert", "Fill all data");
      } else if (profilePicPath.value.isNotEmpty) {
        updateDP();
      } else {
        updateProfile();
      }
    } else {
      if (nameController.value.text.isEmpty ||
          birthController.value.text.isEmpty ||
          emailController.value.text.isEmpty) {
        showSnackbar("Alert", "Fill all data");
      } else if (panPicPath.value.isNotEmpty) {
        updatePan();
      } else if (profilePicPath.value.isNotEmpty) {
        updateDP();
      } else {
        updateProfile();
      }
    }
  }

  updateDP() async {
    isLoading();
    dio.FormData data = dio.FormData.fromMap(
      {
        'id': isSpecialist.value ? specialist.value?.id : user.value?.id,
        "image": profilePicPath.value.isEmpty
            ? user.value?.image.toString()
            : await dio.MultipartFile.fromFile(profilePicPath.value,
                filename: profilePicPath.value.split('/').last,
                contentType: MediaType('image', 'jpeg')),
      },
    );

    //Constant.printValue("form data ${data.files.first.value.contentType}");

    var res = await api.postRequest(
        isSpecialist.value ? AppUrls.specialistUpdateDp : AppUrls.updateDp,
        data);
    isLoading();
    var updateDp = UpdateDpModel.fromJson(res);
    showSnackbar("Message", updateDp.message);

    if (updateDp.status == Status.success.name) {
      updateProfile();
    }
  }

  updatePan() async {
    isLoading();
    dio.FormData data = dio.FormData.fromMap(
      {
        'id': user.value?.id,
        "image": panPicPath.value.isEmpty
            ? user.value?.panImage.toString()
            : await dio.MultipartFile.fromFile(panPicPath.value,
                filename: panPicPath.value.split('/').last,
                contentType: MediaType('image', 'jpeg')),
      },
    );

    var res = await api.postRequest(AppUrls.updatePan, data);
    isLoading();
    if (res != null) {
      showSnackbar("Message", res['message'] ?? "");
      if (res['status'] == 'success') {
        if (profilePicPath.value.isNotEmpty) {
          updateDP();
        } else {
          updateProfile();
        }
      }
    } else {
      showSnackbar("Error", "Image is too large.");
    }
  }

  updateProfile() async {
    isLoading();
    var data = isSpecialist.value
        ? {
            "id": specialist.value?.id,
            "email": emailController.value.text,
            "name": nameController.value.text,
            "priceBefore": priceBeforeController.value.text,
            "officeAddress": addressController.value.text,
            "education": educationController.value.text,
            "city": city.value!.id!,
            "desc": descController.value.text,
            "totalPatients": totalPatientsController.value.text,
            "expereance": experienceController.value.text,
            "price": priceController.value.text,
          }
        : {
            "id": user.value?.id,
            "dob": Constant.changeDateFormat(birthController.value.text,
                upload: true),
            "name": nameController.value.text,
            "email": emailController.value.text,
            "panNumber": panNumberController.value.text,
            "bankName": bankNameController.value.text,
            "accNumber": accNumberController.value.text,
            "accHolderName": accHolderNameController.value.text,
            "ifsc": ifscCodeController.value.text,
          };
    var res = await api.postRequest(
        isSpecialist.value
            ? AppUrls.specialistUpdateProfile
            : AppUrls.updateProfile,
        data);
    isLoading();
    var updateProfile = UpdateProfileModel.fromJson(res);
    showSnackbar("Message", updateProfile.message);

    if (updateProfile.status == Status.success.name) {
      isSpecialist.value
          ? PrefData.saveUserSpecialist(jsonEncode(updateProfile.result))
          : PrefData.saveUser(jsonEncode(updateProfile.result));
      Constant.moveToNextAndReplace(isSpecialist.value
          ? Routes.homeSpecialistScreenRoute
          : Routes.homeScreenRoute);
    }
  }
}
