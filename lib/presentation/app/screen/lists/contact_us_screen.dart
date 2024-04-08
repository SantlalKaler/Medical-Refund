import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lab_test_app/presentation/app/screen/setting_controller.dart';

import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late final SettingController controller;

  @override
  void initState() {
    super.initState();
    Get.delete<SettingController>();
    controller = Get.put(SettingController());
    controller.getSettingsFromLocalStorage();
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
          child: Column(
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {
                backClick();
              }, AppLocalizations.of(context)!.contactUs),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                child: GetBuilder<SettingController>(
                    init: SettingController(),
                    builder: (controller) => controller.loading.value
                        ? showLoading()
                        : Column(
                          children: [
                            buildAboutLabContainer(
                                controller
                                    .settings.value!.result!.contact!.phoneNumber,
                                'call.svg', () {
                                Constant.launchURL(
                                    "tel:${controller.settings.value!.result!.contact!.phoneNumber}");
                              }),
                            buildAboutLabContainer(
                                controller
                                    .settings.value!.result!.contact!.email,
                                'lab_email.svg', () {
                               /* Constant.launchURL(
                                    "tel:${controller.settings.value!.result!.contact!.phoneNumber}");
                             */ }),
                            buildAboutLabContainer(
                                controller
                                    .settings.value!.result!.contact!.address,
                                'my_home_visit.svg', () {
                               /* Constant.launchURL(
                                    "tel:${controller.settings.value!.result!.contact!.phoneNumber}");
                             */ }),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAboutLabContainer(info, icon, ontap) {
    return getShadowDefaultContainer(
      height: 100.h,
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: getCustomFont(info, 18.sp, Colors.black, 2,
                    fontWeight: FontWeight.w400),
              ),
              InkWell(onTap: ontap, child: getImageButtonWithSize(icon)),
            ],
          ),
        ],
      ),
    );
  }
}
