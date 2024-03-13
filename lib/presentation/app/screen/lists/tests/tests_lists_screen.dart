import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
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
  late final HomeController homeController;

  @override
  void initState() {
    homeController = Get.put(HomeController());
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
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
              }, 'Tests'),
              getVerSpace(20.h),
              Expanded(
                child: Column(
                  children: [
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
    double margin = 20.h;
    int crossCount = 3;
    if (context.isTablet) {
      crossCount = 4;
    }
    double width = (MediaQuery.of(context).size.width - (margin * crossCount)) /
        crossCount;
    double height = 140.h;
    LabController labController = Get.find();
    final random = Random();

    return Expanded(
      child: GridView.count(
        crossAxisCount: crossCount,
        crossAxisSpacing: margin,
        mainAxisSpacing: margin,
        childAspectRatio: width / height,
        children: List.generate(labController.tests.length, (index) {
          Tests test = labController.tests[index];
          return singleTestView(test, () {
            Constant.sendToNext(context, Routes.testDetailScreenRoute,
                arguments: test.id);
          }, colorList[random.nextInt(colorList.length)].toColor());
        }),
      ),
    );
  }
}

Widget singleTestView(Tests test, onTap, Color color,
    {bool showPrice = false, bool testSelected = false}) {
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
              if (showPrice)
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
                      'Price',
                      Constant.getRuppee(test.priceBefore),
                      '',
                    ),
                    buildTaxRow('Pay only', Constant.getRuppee(test.price), '',
                        fontWeight: FontWeight.w700),
                    getVerSpace(10.h),
                    buildTaxRow('MR will pay',
                        Constant.getRuppee(test.priceBefore! - test.price!), '',
                        color: accentColor),
                  ],
                )
              : Container(),
        ],
      ),
    ),
  );
}
