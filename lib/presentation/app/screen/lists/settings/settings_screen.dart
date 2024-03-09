import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';
import '../../setting_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingController controller;

  @override
  void initState() {
    super.initState();
    Get.delete<SettingController>();
    controller = Get.put(SettingController());
    controller.getPageList();
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
              }, 'Settings'),
              getVerSpace(20.h),
              buildSettingTabList(context)
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildSettingTabList(BuildContext context) {
    return Expanded(
        child: GetBuilder<SettingController>(
            init: SettingController(),
            builder: (controller) {
              return controller.loading.value
                  ? showLoading()
                  : controller.pages.value!.result!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            var page = controller.pages.value!.result![index];
                            return Column(
                              children: [
                                buildDefaultTabWidget(
                                    'E7FCE2', 'terms.svg', page.title!,
                                        () {
                                      controller.page.value = index;
                                      Constant.sendToNext(
                                          context, Routes.privacyPolicyNTerms);
                                    }, showIcon: false),
                                getDivider().marginSymmetric(vertical: 16.h),
                              ],
                            ).marginSymmetric(horizontal: 20.h);
                          },
                          itemCount: controller.pages.value!.result!.length)
                      : getEmptyView();
            }));
  }
}
