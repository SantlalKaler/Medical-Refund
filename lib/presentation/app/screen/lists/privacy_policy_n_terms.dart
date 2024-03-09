import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/setting_controller.dart';

import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class PrivacyPolicyNTermsScreen extends StatefulWidget {
  const PrivacyPolicyNTermsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyNTermsScreenState();
  }
}

class _PrivacyPolicyNTermsScreenState extends State<PrivacyPolicyNTermsScreen> {
  late SettingController controller;
  var data = Get.arguments;

  @override
  void initState() {
    controller = Get.put(SettingController());
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getVerSpace(20.h),
                getBackAppBar(context, () {
                  backClick();
                }, controller.pages.value!.result![controller.page.value].title!),
                buildAboutView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAboutView(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) => controller.loading.value
            ? showLoading()
            : Padding(
                padding: EdgeInsets.all(15.h),
                child: buildDescriptionView(controller
                    .pages.value!.result![controller.page.value].content!),
              ));
  }

  Widget buildDescriptionView(String description) {
    return getMultilineCustomFont(
        Constant.removeHtmlTags(
          description,
        ),
        17.sp,
        Colors.black,
        txtHeight: 1.8.h);
  }
}
