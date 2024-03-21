import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/presentation/app/screen/lists/profile/profile_controller.dart';

import '../../../../../data/app_urls.dart';
import '../../../../../domain/model/auth/user.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/widget_utils.dart';
import '../../../controller/controller.dart';
import '../../../routes/app_routes.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreenState();
  }
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late final ProfileController profileController;

  BottomItemSelectionController navController =
      Get.put(BottomItemSelectionController());

  @override
  void initState() {
    Get.delete<ProfileController>();
    profileController = Get.put(ProfileController());
    profileController.getUser();
    super.initState();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerSpace(20.h),
                    GetBuilder<ProfileController>(
                        init: ProfileController(),
                        builder: (controller) => controller.user.value ==
                                    null &&
                                controller.specialist.value == null
                            ? getEmptyView()
                            : Column(
                                children: [
                                  getBackAppBar(context, () {
                                    backClick();
                                  }, 'My Profile',
                                      withLeading:
                                          !controller.isSpecialist.value),
                                  getVerSpace(20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      getCircularNetworkImage(
                                              context,
                                              92.h,
                                              92.h,
                                              22.h,
                                              "${AppUrls.imageBaseUrl}${controller.isSpecialist.value ? controller.specialist.value?.image : controller.user.value!.image!}",
                                              boxFit: BoxFit.fill,
                                      placeHolder: "profile_active.svg")
                                          .marginSymmetric(horizontal: 20.h),
                                   /*   InkWell(
                                          onTap: () {
                                            PrefData.setIsSignIn(false);
                                            PrefData.clearUser();
                                            navController.bottomBarSelectedItem
                                                .value = 0;
                                            Constant.moveToNextAndReplace(
                                                Routes.loginRoute);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: getSvgImage("logout.svg"),
                                          )),*/
                                    ],
                                  ),
                                  getVerSpace(31.h),
                                  buildProfileTextField(
                                          user: controller.user.value,
                                          specialist:
                                              controller.specialist.value)
                                      .marginSymmetric(horizontal: 20.h),
                                  getVerSpace(30.h),
                                  buildEditProfileButton(context),
                                  getVerSpace(50.h),
                                ],
                              )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Wrap buildProfileTextField({User? user, Specialist? specialist}) {
    Constant.printValue("Pan number is ${user?.panNumber}\n"
        "pan image : ${AppUrls.imageBaseUrl}${user?.panImage}");

    return Wrap(
      children: [
        buildRow('Full Name', user != null ? user.name! : specialist!.name!),
        getDivider().marginSymmetric(vertical: 16.h),
        buildRow('Email', user != null ? user.email! : ""),
        getDivider().marginSymmetric(vertical: 16.h),
        buildRow('Mobile Number',
            '+91 ${user != null ? user.mobile! : specialist!.mobile!}'),
        getDivider().marginSymmetric(vertical: 16.h),
        Visibility(
          visible: user != null,
          child: Column(
            children: [
              buildRow(
                  'Date of Birth',
                  Constant.changeDateFormat(
                      user != null ? user.dobDate! : "1997-09-09")),
              getDivider().marginSymmetric(vertical: 16.h),
             /* buildRow('Bank Name', user!.bankName ?? ""),
              getDivider().marginSymmetric(vertical: 16.h),
              buildRow('A/C Number', user.accNumber ?? ""),
              getDivider().marginSymmetric(vertical: 16.h),
              buildRow('A/C Holder', user.accHolderName ?? ""),
              getDivider().marginSymmetric(vertical: 16.h),
              buildRow('IFSC', user.ifsc ?? ""),
              getDivider().marginSymmetric(vertical: 16.h),*/
              buildRow('Pan Number', user!.panNumber ?? ""),
              getDivider().marginSymmetric(vertical: 16.h),
              if (user.panImage != null && user.panImage!.isNotEmpty)
                getCircularNetworkImage(context, double.infinity, 150.h, 22.h,
                    "${AppUrls.imageBaseUrl}${user.panImage}",
                    boxFit: BoxFit.fill)
            ],
          ),
        ),
        specialist != null
            ? Column(
                children: [
                  buildRow('Office Address', specialist.officeAddress ?? ""),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Education', specialist.education ?? ""),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Experience', specialist.expereance ?? ""),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Avg. Rating', specialist.avgRating.toString()),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow(
                      'Total Rating Count', specialist.totalRating.toString()),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Price Before', specialist.priceBefore.toString()),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Price', specialist.price.toString()),
                  getDivider().marginSymmetric(vertical: 16.h),
                  buildRow('Admin Commission',
                      specialist.adminCommission.toString()),
                  getDivider().marginSymmetric(vertical: 16.h),
                ],
              )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget buildEditProfileButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Edit Profile',
      Colors.white,
      () {
        Constant.sendToNext(context, Routes.editProfileScreenRoute);
      },
      18.sp,
      borderRadius: BorderRadius.all(Radius.circular(22.h)),
      buttonHeight: 60.h,
    ).marginSymmetric(horizontal: 20.h);
  }

}
  Row buildRow(String title, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont(title, 17.sp, greyFontColor, 1,
            fontWeight: FontWeight.w500),
        getCustomFont(name, 17.sp, Colors.black, 1,
            fontWeight: FontWeight.w500),
      ],
    );
  }
