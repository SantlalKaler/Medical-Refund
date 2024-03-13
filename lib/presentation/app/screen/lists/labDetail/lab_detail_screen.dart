import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/Lab.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

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
                                  getVerSpace(140.h),
                                  buildAboutLabContainer(controller
                                      .labDetails.value!.result!.detail!),
                                  getVerSpace(20.h),
                                  buildTitleRow('About', () {
                                    Constant.sendToNext(
                                        context, Routes.aboutLabScreenRoute);
                                  }),
                                  buildTestsListView(),
                                  getVerSpace(20.h),
                                  getButton(
                                    context,
                                    accentColor,
                                    'Select Lab to proceed',
                                    Colors.white,
                                    () {
                                      if (controller.selectedTests.isEmpty) {
                                        showSnackbar("Warning!",
                                            "Please select any test to continue");
                                      } else {
                                        Constant.moveToNext(
                                            Routes.addBookingScreenRoute,
                                            arguments: {
                                              'multiTests':true,
                                            });
                                      }
                                    },
                                    18.sp,
                                    weight: FontWeight.w700,
                                    buttonHeight: 60.h,
                                    buttonWidth: double.infinity,
                                    borderRadius: BorderRadius.circular(22.h),
                                  )
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final random = Random();

    return GetBuilder(
        init: LabController(),
        builder: (controller) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossCount,
            crossAxisSpacing: margin,
            mainAxisSpacing: margin,
            childAspectRatio: height / (width * 2.6),
            children: List.generate(controller.tests.length, (index) {
              Tests test = controller.tests[index];

              return singleTestView(test, () {
                controller.selectTest(test);
              }, colorList[random.nextInt(colorList.length)].toColor(),
                  showPrice: true, testSelected: isTestSelected(test));
            }),
          );
        });
  }

  bool isTestSelected(Tests test) {
    var isSelected = false;
    for (var selectedTest in controller.selectedTests) {
      /* Constant.printValue("Selected test id : ${selectedTest.id}\n"
          "Test id : ${test.id}");*/
      if (selectedTest.id == test.id) {
        isSelected = true;
        break;
      } else {
        isSelected = false;
      }
    }
    /* Constant.printValue(
        "${test.test?.title} is Selected $isSelected\nSelecte test : ${controller.selectedTests.length}");
   */
    return isSelected;
  }
}
