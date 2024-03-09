import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/presentation/app/screen/lists/profile/profile_controller.dart';
import 'package:lab_test_app/presentation/app/screen/login/login_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/widget_utils.dart';
import '../../../controller/controller.dart';
import '../../../routes/app_routes.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabProfileState();
  }
}

class _TabProfileState extends State<TabProfile> {
  BottomItemSelectionController navController =
      Get.put(BottomItemSelectionController());

  late final ProfileController profileController;

  @override
  void initState() {
    Get.delete<ProfileController>();
    profileController = Get.put(ProfileController());
    profileController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: fillColor,
          child: Column(
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {}, 'Profile',
                  withAction: true,
                  withLeading: false,
                  isDivider: false,
                  actionIcon: 'setting.svg',
                  iconColor: Colors.black, actionClick: () {
                Constant.sendToNext(context, Routes.settingsScreenRoute);
              }),
              getVerSpace(27.h),
              buildProfileView(context),
              getVerSpace(26.h),
              buildTabContainer(context)
            ],
          ),
        )
      ],
    );
  }

  Widget buildProfileView(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => controller.user.value == null
          ? getEmptyView()
          : Row(
              children: [
                getCircularNetworkImage(
                    context,
                    92.h,
                    92.h,
                    22.h,
                    controller.user.value?.image == null
                        ? Constant.profilePic
                        : "${AppUrls.imageBaseUrl}${controller.user.value!.image!}",
                    boxFit: BoxFit.fill),
                getHorSpace(12.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                        controller.user.value!.name!, 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                    getVerSpace(3.h),
                    getCustomFont(controller.user.value!.email ?? '', 15.sp,
                        Colors.black, 1,
                        fontWeight: FontWeight.w500),
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 20.h),
    );
  }

  Expanded buildTabContainer(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.h),
                topRight: Radius.circular(40.h)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x289a90b8),
                blurRadius: 32.h,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: buildTabView(context),
        ));
  }

  buildTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDefaultTabWidget('#FFEBF5', 'profile.svg', 'My Profile', () {
            Constant.sendToNext(context, Routes.myProfileScreenRoute);
          }),
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#F9F7DB', 'my_home_visit.svg', 'My Home Visit',
              () {
            Constant.sendToNext(context, Routes.myHomeVisitScreenRoute);
          }),
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#E7EEFF', 'my_tests.svg', 'My Test Bookings',
              () {
            Constant.sendToNext(context, Routes.myBookingScreenRoute);
          }),
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#F9F7DB', 'situation.svg', 'My Networks', () {
            Constant.sendToNext(context, Routes.myNetworksScreenRoute);
          }),
          /*
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#FFEDE2', 'card.svg', 'My Cards', () {
            Constant.sendToNext(context, Routes.myCardScreenRoute);
          }),*/
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#FFEBF5', 'wallet_outline.svg', 'My Wallet',
              () {
            Constant.sendToNext(context, Routes.myWalletScreenRoute);
          }),
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#FFEBF5', 'share.svg', 'Refer & Earn', () {
            var referralLink =
                'https://yourapp.com/referral/abcd1234\nRegister with Refer code : ${profileController.user.value!.refCode!}\nEarn Upto 50%';
            shareReferralLink(referralLink);
          }),
          getDivider().marginSymmetric(vertical: 16.h),
          buildDefaultTabWidget('#FFEBF5', 'contact.svg', 'Contact Us', () {
            Constant.moveToNext(Routes.contactUs);
          }),
          getVerSpace(57.h),
          buildLogOutButton(context),
          getVerSpace(57.h),
        ],
      ),
    );
  }

  void shareReferralLink(String referralLink) {
    Share.share(referralLink);
  }

  Widget buildLogOutButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Logout',
      Colors.white,
      () {
        PrefData.setIsSignIn(false);
        PrefData.clearUser();
        navController.bottomBarSelectedItem.value = 0;
        Get.offAll(const LoginScreen());
      },
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.all(Radius.circular(22.h)),
    );
  }
}
