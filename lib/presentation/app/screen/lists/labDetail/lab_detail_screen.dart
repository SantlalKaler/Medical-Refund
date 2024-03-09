import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/Lab.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../../data/response_status.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../routes/app_routes.dart';
import '../tests/tests_lists_screen.dart';

class LabDetailScreen extends StatefulWidget {
  const LabDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LabDetailScreenState();
  }
}

class _LabDetailScreenState extends State<LabDetailScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late LabController controller;

  @override
  void initState() {
    var labId = Get.arguments;
    Get.delete<LabController>();
    controller = Get.put(LabController());
    controller.getLabDetails(labId);
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
        extendBodyBehindAppBar: true,
        body: GetBuilder<LabController>(
          init: LabController(),
          builder: (controller) => controller.loading.value
              ? Center(
                  child: showLoading(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: [
                          Stack(
                            children: [
                              buildTopImageView(controller.image.value),
                              Column(
                                children: [
                                  getVerSpace(40.h),
                                  getBackAppBar(context, () {
                                    backClick();
                                  }, '',
                                      isDivider: false,
                                      iconColor: Colors.white),
                                  // Align(alignment: Alignment.centerLeft,child: getBackIcon((){},color: Colors.white)),
                                  getVerSpace(140.h),
                                  buildAboutLabContainer(controller
                                      .labDetails.value!.result!.detail!),
                                  /*getVerSpace(30.h),
                              Row(
                                children: [
                                  getCircleImage(
                                      context, 'specialist1.png', 68.h),
                                  getHorSpace(12.h),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        getCustomFont('Dr. Vina Belgium',
                                            16.sp, Colors.black, 1,
                                            fontWeight: FontWeight.w700),
                                        getVerSpace(3.h),
                                        getCustomFont('Owner', 15.sp,
                                            greyFontColor, 1,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Constant.sendToNext(
                                          context, Routes.chatScreenRoute);
                                    },
                                    child: Container(
                                      height: 51.h,
                                      width: 51.h,
                                      decoration: BoxDecoration(
                                        color: fillColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                          child: getSvgImage('chat.svg',
                                              height: 24.h,
                                              width: 24.h,
                                              color: accentColor)),
                                    ),
                                  )
                                ],
                              ),*/
                                  getVerSpace(20.h),
                                  buildTitleRow('About', () {
                                    Constant.sendToNext(
                                        context, Routes.aboutLabScreenRoute);
                                  }),
                                  getVerSpace(20.h),
                                  buildTitleRow('Location', () {
                                    var lat = controller
                                        .labDetails
                                        .value!
                                        .result!
                                        .detail!
                                        .position!
                                        .coordinates![0];
                                    var lng = controller
                                        .labDetails
                                        .value!
                                        .result!
                                        .detail!
                                        .position!
                                        .coordinates![1];
                                    if (lat == 0 || lng == 0) {
                                      showSnackbar(
                                          "Message", "Invalid location");
                                      return;
                                    }
                                    MapsLauncher.launchCoordinates(lat, lng);
                                  }),
                                  getVerSpace(20.h),
                                  // buildTitleRow('Reviews', () {
                                  //   Constant.sendToNext(
                                  //       context, Routes.labReviewsScreenRoute,
                                  //       arguments: {
                                  //         'lab': controller.lab.value!.id
                                  //       });
                                  // }),
                                  // getVerSpace(20.h),
                                  buildTestsListView(),
                                  getVerSpace(30.h),
                                ],
                              ).marginSymmetric(horizontal: 20.h),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // buildHomeVisitButton(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildAboutLabContainer(Lab lab) {
    return getShadowDefaultContainer(
      height: 200.h,
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.all(20.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getCustomFont(lab.name!, 22.sp, Colors.black, 2,
                  fontWeight: FontWeight.w700),
              Row(
                children: [
                  InkWell(
                      onTap: () => Constant.launchURL(
                          "tel:${lab.phone ?? '1234567890'}"),
                      child: getImageButtonWithSize('call.svg')),
                  getHorSpace(10.w),
                  InkWell(
                      onTap: () => Constant.moveToNext(Routes.chatScreenRoute,
                              arguments: {
                                "receiverId": lab.id,
                                "receiverType": ChatWith.lab.name
                              }),
                      child: getImageButtonWithSize('chat.svg')),
                ],
              ),
            ],
          ),
          getVerSpace(14.h),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(22.h)),
                color: 'F8F8FC'.toColor(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*buildContactRow(lab.phone!, 'lab_phone.svg'),
                  getVerSpace(20.h),
                  buildContactRow(lab.email!, 'lab_email.svg'),
                  getVerSpace(20.h),*/
                  buildContactRow(
                      '${lab.openFrom} to ${lab.openTo}', 'lab_clock.svg'),
                  // getVerSpace(20.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildHomeVisitButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      "Select Test to proceed",
      Colors.white,
      () {},
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.circular(22.h),
      borderWidth: 2.h,
    ).marginSymmetric(horizontal: 20.h, vertical: 30.h);
  }

  Container buildTopImageView(imgPath) {
    return Container(
      height: 297.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22.h),
            bottomRight: Radius.circular(22.h)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x99000000), Color(0x00000000)],
          ),
        ),
        child: getNetworkImage(imgPath),
      ),
    );
  }

  Row buildContactRow(String text, String icon) {
    return Row(
      children: [
        getSvgImage(icon, height: 20.h, width: 20.h),
        getHorSpace(8.h),
        getCustomFont(text, 17.sp, Colors.black, 1, fontWeight: FontWeight.w500)
      ],
    );
  }

  Widget buildTestsListView() {
    var colorList = DataFile.colorList;
    double margin = 10.h;
    int crossCount = 2;
    if (context.isTablet) {
      crossCount = 4;
    }

    final random = Random();

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossCount,
      crossAxisSpacing: margin,
      mainAxisSpacing: margin,
      childAspectRatio: 0.90,
      children: List.generate(controller.tests.length, (index) {
        Tests test = controller.tests[index];

        return singleTestView(test, () {
          Constant.moveToNext(Routes.addBookingScreenRoute, arguments: {
            'lab': controller.lab.value,
            'test': test,
            'adminCommission': test.adminCommission
          });
        }, colorList[random.nextInt(colorList.length)].toColor(),
            showPrice: true);
      }),
    );
  }
}
