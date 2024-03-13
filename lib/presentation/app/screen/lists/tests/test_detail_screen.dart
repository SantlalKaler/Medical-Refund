import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/test.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';
import 'package:lab_test_app/presentation/app/screen/lists/tests/test_controller.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';

class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestDetailScreenState();
  }
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late final TestController controller;

  @override
  void initState() {
    super.initState();
    Get.delete<TestController>();
    controller = Get.put(TestController());
    controller.getTest(Get.arguments);
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
              getBackAppBar(
                context,
                () {
                  backClick();
                },
                'Test Detail',
              ),
              getVerSpace(20.h),
              GetBuilder<TestController>(
                  init: TestController(),
                  builder: (controller) => controller.loading.value
                      ? showLoading()
                      : Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              buildTestDetailLabListView(),
                              getVerSpace(20.h),
                              buildTopContainer(),
                              getVerSpace(35.h),
                            ],
                          ),
                        )),
              // buildProceedButton(context),
              // getVerSpace(30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopContainer() {
    Test? test = controller.testDetails.value!.result!.test;
    return Column(
      children: [
        getShadowDefaultContainer(
            // height: 404.h,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont('02 August, 2022', 17.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getSvgImage('menu.svg', height: 24.h, width: 24.h),
                  ],
                ),
                getVerSpace(14.h),*/
                getCustomFont(test!.title!, 22.sp, Colors.black, 2,
                    fontWeight: FontWeight.w700),
                getVerSpace(6.h),
                getCustomFont(test.shortDesc!, 15.sp, greyFontColor, 3,
                    fontWeight: FontWeight.w500),
                getVerSpace(20.h),
                getDivider(),
                getVerSpace(20.h),
                /*
                getMultilineCustomFont(
                    Constant.removeHtmlTags(test.desc!), 17.sp, greyFontColor,
                    txtHeight: 1.5),*/
                HtmlWidget(test.desc!, ),
               /* ReadMoreText(
                  Constant.removeHtmlTags(test.desc!),
                  trimLines: 5,
                  colorClickableText: Colors.red,
                  lessStyle: TextStyle(fontSize: 17.sp, color: accentColor),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(fontSize: 17.sp, color: accentColor),
                )*/
                /*buildTaxRow('Tax', '\$1.50'),
                getVerSpace(20.h),
                buildTaxRow('GST', '\$2.50'),
                getVerSpace(20.h),
                buildTaxRow('Sub Total', '\$209'),
                getVerSpace(20.h),
                getDivider(),
                getVerSpace(20.h),
                getTotalRow()*/
              ],
            )),
      ],
    );
  }

  Widget buildTestDetailLabListView() {
    var labsList = controller.testDetails.value!.result!.priceList!;
    var test = controller.testDetails.value!.result!.test;

    return labsList.isEmpty
        ? const Text(
            'No labs found!',
            textAlign: TextAlign.center,
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: labsList.length,
            itemBuilder: (context, index) {
              var labPrice = labsList[index];
              return GestureDetector(
                onTap: () {
                  // Constant.moveToNext(Routes.addBookingScreenRoute, arguments: {
                  //   'test': controller.testDetails.value!.result!.test!,
                  //   'priceList': labPrice
                  // });
                },
                child: getShadowDefaultContainer(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        labPrice.labImage!,
                        width: 100,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            getCustomFont(
                                labPrice.labName!, 18.sp, Colors.black, 1,
                                fontWeight: FontWeight.w700),
                            getVerSpace(5.h),
                            buildLocationRow(
                                labPrice.officeAddress!, Get.width, 2),
                            getVerSpace(10.h),
                            getDivider(),
                            getVerSpace(10.h),
                            buildTaxRow('Price',
                                Constant.getRuppee(labPrice.priceBefore), ''),
                            buildTaxRow('Pay only',
                                Constant.getRuppee(labPrice.price), ''),
                            buildTaxRow(
                                'MR will pay',
                                Constant.getRuppee(
                                    labPrice.priceBefore! - labPrice.price!),
                                '', color: accentColor),
                            // buildTaxRow('Price', Constant.getRuppee(labPrice.price),
                            //     Constant.getRuppee(labPrice.priceBefore)),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      style: const ButtonStyle(
                                        minimumSize: MaterialStatePropertyAll(
                                            Size(double.infinity, 40)),
                                      ),
                                      onPressed: () async {
                                        LabController labController =
                                            Get.find();
                                        await labController
                                            .getLabWithSingleTest(
                                                labPrice.labId, test!.id);

                                        Constant.moveToNext(
                                            Routes.addBookingScreenRoute,
                                            arguments: {
                                              'lab': labController
                                                  .labWithTestData
                                                  .value!
                                                  .result!
                                                  .detail,
                                              'test': labController
                                                  .labWithTestData
                                                  .value!
                                                  .result!
                                                  .tests![0],
                                              'adminCommission': labController
                                                  .labWithTestData
                                                  .value!
                                                  .result!
                                                  .tests![0]
                                                  .adminCommission
                                            });
                                      },
                                      child: Text(
                                        'Book now \n${Constant.getRuppee(labPrice.price)}',
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                      style: const ButtonStyle(
                                        minimumSize: MaterialStatePropertyAll(
                                            Size(double.infinity, 40)),
                                      ),
                                      onPressed: () {
                                        Constant.moveToNext(
                                            Routes.labDetailScreenRoute,
                                            arguments: "${labPrice.labId}");
                                      },
                                      child: const Text('View in lab')),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ).marginSymmetric(horizontal: 4.h),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  Row getTotalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getCustomFont('Grand Total', 18.sp, Colors.black, 1,
            fontWeight: FontWeight.w600),
        getCustomFont('\$209', 20.sp, Colors.black, 1,
            fontWeight: FontWeight.w700)
      ],
    );
  }

  Widget buildProceedButton(BuildContext context) {
    // var priceList = controller.testDetails.value!.result!.priceList!;
    // var labPrice = priceList[0];
    return getButton(
      context,
      accentColor,
      'Select Lab to proceed',
      Colors.white,
      () {},
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.circular(22.h),
    ).marginSymmetric(horizontal: 20.h);
  }
}

Row buildTaxRow(String title, String rate, String oldRate, {FontWeight? fontWeight, Color? color, double? fontSize}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getCustomFont(title, 17.sp, color ?? Colors.black, 1, fontWeight:fontWeight ?? FontWeight.w500),
      Row(
        children: [
          getCustomFont(oldRate, fontSize ?? 17.sp, color ?? greyFontColor, 1,
              fontWeight: fontWeight ?? FontWeight.w300,
              decoration: TextDecoration.lineThrough),
          getHorSpace(10.h),
          getCustomFont(rate, fontSize ?? 17.sp, color ?? Colors.black, 1,
              fontWeight: fontWeight ?? FontWeight.w500),
          getHorSpace(10.h),
        ],
      ),
    ],
  );
}

Widget buildTotalAmountRow(bookingAmount, pendingAmount,
    {bool isTestBooking = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      isTestBooking
          ? getCustomFont(
              "Lab price ${Constant.getRuppee(bookingAmount)}\nYou pay only at Lab ${Constant.getRuppee(pendingAmount)}\nMR will pay ${Constant.getRuppee(bookingAmount - pendingAmount)}",
              18.sp,
              Colors.black,
              5,
              fontWeight: FontWeight.w500)
          : getCustomFont(
              "Booking price ${Constant.getRuppee(bookingAmount)}\nPending amount at Lab ${Constant.getRuppee(pendingAmount)}",
              18.sp,
              Colors.black,
              2,
              fontWeight: FontWeight.w500),
      /* getCustomFont(Constant.getRuppee(price), 28.sp, accentColor, 1,
          fontWeight: FontWeight.w700)*/
    ],
  ).marginSymmetric(horizontal: 20.h);
}
