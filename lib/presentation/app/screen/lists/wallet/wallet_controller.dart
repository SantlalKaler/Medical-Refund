import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/CommonModel.dart';
import 'package:lab_test_app/domain/model/SettingModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../data/api.dart';
import '../../../../../data/response_status.dart';
import '../../../../../domain/model/WalletModel.dart';

class WalletController extends GetxController {
  var settings = Rxn<SettingModel>();
  var user = Rxn<User>();
  var wallet = Rxn<WalletModel>();

  final amountController = TextEditingController().obs;
  RxBool loading = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
    getWallet();
  }

  getSettings() async {
    setLoading();
    var res = await api.getRequest(AppUrls.settings, {"": ""});

    setLoading();
    settings.value = SettingModel.fromJson(res);
    if (settings.value?.status == Status.success.name) {
      PrefData.saveSettings(jsonEncode(settings.value));
    }
    update();
  }

  getSettingsFromLocalStorage() async {
    settings.value = await PrefData.getSettings();
    update();
  }

  getWallet() async {
    setLoading();
    var res = await api.getRequest(AppUrls.wallet, {
      "id": user.value?.id,
      "pageNumber": '1',
      "pageSize": '20'
    });
    setLoading();
    wallet.value = WalletModel.fromJson(res);
    update();
  }

  requestWithdrawals() async {
    setLoading();
    var res = await api.postRequest(AppUrls.requestWithdrawals,
        {"user": user.value?.id, "amount": amountController.value.text});
    setLoading();
    CommonModel commonModel = CommonModel.fromJson(res);
    showSnackbar("Message", commonModel.message);
    update();
  }
}
