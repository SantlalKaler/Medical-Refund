import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';

import '../../../../../domain/model/test.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../routes/app_routes.dart';
import '../../home/home_controller.dart';
import 'test_detail_screen.dart';

class TestsListsScreen extends StatefulWidget {
  const TestsListsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestsListsScreenState();
  }
}

class _TestsListsScreenState extends State<TestsListsScreen> {
  HomeController homeController = Get.find();
  bool fromHome = true;

  @override
  void initState() {
    var args = Get.arguments;
    if (args != null) {
      fromHome = args['fromHome'];
    }
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.printValue("from Home $fromHome");
    initializeScreenSize(context);
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
              }, AppLocalizations.of(context)!.tests,),
              getVerSpace(20.h),
              Expanded(
                child: Column(
                  children: [
                    if (homeController.homeData.value?.tests != null &&
                        homeController.homeData.value!.tests!.isNotEmpty)
                      buildTestsListView(),
                    //buildAddTestButton(context)
                  ],
                ).marginSymmetric(horizontal: 20.h),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddTestButton(BuildContext context) {
    return getButton(
      context,
      accentColor,
      'Add Test',
      Colors.white,
      () {},
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.circular(22.h),
    ).marginSymmetric(vertical: 15.h);
  }

  Expanded buildTestsListView() {
    var colorList = DataFile.colorList;
    double margin = 10.h;
    int crossCount = 2;
    if (context.isTablet) {
      crossCount = 4;
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    LabController labController = Get.find();
    final random = Random();

    return Expanded(
      child: GridView.count(
        crossAxisCount: crossCount,
        crossAxisSpacing: margin,
        mainAxisSpacing: margin,
        childAspectRatio: height / (width * 1.5),
        children: List.generate(
            homeController.homeData.value!.tests?.length ?? 0, (index) {
          Test test = homeController.homeData.value!.tests![index];
          return singleTestViewForHome(test, () {
            Constant.sendToNext(context, Routes.testDetailScreenRoute,
                arguments: test.id!);
          }, colorList[random.nextInt(colorList.length)].toColor(),
              showPrice: true);
        }),
      ),
    );
  }
}

Widget singleTestView(Tests test, onTap, Color color,
    {bool showPrice = false,
    bool testSelectable = false,
    bool testSelected = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        borderRadius: SmoothBorderRadius.all(
            SmoothRadius(cornerRadius: 22.h, cornerSmoothing: 20.h)),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (testSelectable)
                Checkbox(
                    value: testSelected,
                    onChanged: (value) {
                      onTap();
                    }),
              Expanded(
                child: getCustomFont(
                    test.test!.title ?? '', 15.sp, Colors.black, 30,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          showPrice
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getVerSpace(12.h),
                    buildTaxRow(
                      'Booking',
                      Constant.getRuppee(test.bookingPrice),
                      '',
                    ),
                    buildTaxRow(
                      'Price',
                      Constant.getRuppee(test.priceBefore),
                      '',
                    ),
                    buildTaxRow('Pay only', Constant.getRuppee(test.price), '',
                        fontWeight: FontWeight.w700),
                    getVerSpace(10.h),
                    buildTaxRow('MR will pay',
                        Constant.getRuppee(test.priceBefore! - test.price!), '',
                        color: accentColor, fontSize: 14),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}

Widget singleTestViewForHome(Test test, onTap, Color color,
    {bool showPrice = false,
    bool testSelectable = false,
    bool testSelected = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        borderRadius: SmoothBorderRadius.all(
            SmoothRadius(cornerRadius: 22.h, cornerSmoothing: 20.h)),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: getCustomFont(test.title ?? '', 15.sp, Colors.black, 4,
                    fontWeight: FontWeight.w700, ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
