import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/MyBookingResponse.dart';
import 'package:lab_test_app/presentation/base/color_data.dart';

import '../../../../../domain/model/test.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../models/model_home_visit.dart';
import '../../home/tab/tab_home_visit.dart';
import '../../home/tab/tab_test_report.dart';
import '../boooking/booking_controller.dart';

class MyHomeVisitScreen extends StatefulWidget {
  const MyHomeVisitScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomeVisitScreenState();
  }
}

class _MyHomeVisitScreenState extends State<MyHomeVisitScreen> {
  late BookingController controller;

  @override
  void initState() {
    Get.delete<BookingController>();
    controller = Get.put(BookingController());
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  List<ModelHomeVisit> homeVisitList = DataFile.homeVisitList;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(20.h),
            getBackAppBar(context, () {
              backClick();
            }, 'My Home Visit'),
            getVerSpace(10.h),
            GetBuilder<BookingController>(
                init: BookingController(),
                builder: (controller) {
                  return (controller.loading.value)
                      ? showLoading()
                      : buildVisitList(controller.myHomeVisitBookings, context);
                }),
          ],
        )),
      ),
    );
  }
}

Widget buildVisitList(List<Booking> bookings, BuildContext context,
    {bool isSpecialist = false}) {
  Constant.printValue("in side builid visit list : ${bookings.length}");

  return (bookings.isEmpty)
      ? Center(child: buildNoDataWidget(context))
      : Expanded(
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              Booking booking = bookings[index];
              var lab = booking.labs;
              var specialist = booking.specialist;
              var user = booking.users!;

              var bookingStatus = booking.bookingStatus == 0
                  ? "Pending"
                  : booking.bookingStatus == 1
                      ? "Confirmed"
                      : booking.bookingStatus == 2
                          ? "Completed"
                          : "Cancelled";

              Constant.printValue("Lab : ${booking.labs}\n"
                  "Specialist : ${booking.specialist}\n"
                  "user : ${booking.users}");

              // total booking amount
              num bookingAmount = 0;
              if (booking.test != null && booking.test!.isNotEmpty){
                for(var tst in booking.test!){
                  bookingAmount += tst.bookingPrice ?? 0;
                }
              }

                return getShadowDefaultContainer(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  padding: EdgeInsets.all(20.h),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont(
                              isSpecialist
                                  ? booking.patientName!
                                  : lab?.name ?? specialist?.name ?? "",
                              16.sp,
                              Colors.black,
                              1,
                              fontWeight: FontWeight.w700),
                          //getSvgImage('menu.svg', height: 24.h, width: 24.h)
                        ],
                      ),
                      getVerSpace(3.h),
                      getCustomFont(
                          isSpecialist
                              ? user.mobile ?? ""
                              : lab?.officeAddress ??
                                  specialist?.officeAddress ??
                                  "",
                          15.sp,
                          Colors.black,
                          2,
                          fontWeight: FontWeight.w500),
                      getVerSpace(20.h),
                      buildDateTimeRow(
                          Constant.changeDateFormat(booking.collectionDate!),
                          booking.collectionSlot!),
                      getVerSpace(20.h),
                      buildPaymentInfoRow(
                          Constant.getRuppee(bookingAmount.toString()),
                          (booking.paymentGateway == null ||
                                  booking.paymentGateway!.isEmpty)
                              ? "Payment Pending"
                              : "Payment Success"),
                      getVerSpace(20.h),
                      Row(
                        children: [
                          getSvgImage('booking_done.svg',
                              height: 20.h, width: 20.h),
                          getHorSpace(4.h),
                          getCustomFont(
                              "Booking $bookingStatus", 15.sp, accentColor, 1,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      getVerSpace(20.h),
                      if (booking.test != null && booking.test!.isNotEmpty)
                        showTestInfoList(context, booking.test!)
                      // buildVisitCompleteButton(context)
                    ],
                  ));
            },
          ),
        );
}

Widget showTestInfoList(BuildContext context, List<Test> tests) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      getCustomFont("Tests", 16.sp, Colors.black, 2,
          fontWeight: FontWeight.w700),
      getVerSpace(10.h),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: height / (width * 2.1),
        children: List.generate(tests.length, (index) {
          Test test = tests[index];
          return singleTestInfo(test);
        }),
      ),
    ],
  );
}

Widget singleTestInfo(Test test) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 140,
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          borderRadius: SmoothBorderRadius.all(
              SmoothRadius(cornerRadius: 22.h, cornerSmoothing: 20.h)),
          color: "FFF4DF".toColor(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(test.title ?? '', 15.sp, Colors.black, 3,
                fontWeight: FontWeight.w600),
            getVerSpace(10),
            getCustomFont("Booking : ${Constant.getRuppee(test.bookingPrice)}",
                14.sp, Colors.black, 1),
            getCustomFont("Price : ${Constant.getRuppee(test.price)}", 14.sp,
                Colors.black, 1),
            getCustomFont(
                "Pending : ${Constant.getRuppee((test.price ?? 0) - (test.bookingPrice ?? 0))}",
                14.sp,
                Colors.black,
                1),
          ],
        ),
      ),
    ],
  );
}

Widget buildVisitCompleteButton(BuildContext context) {
  return getButton(
    context,
    'EFFAF0'.toColor(),
    'Visit Completed',
    "3CBC00".toColor(),
    () {},
    15.sp,
    weight: FontWeight.w500,
    buttonHeight: 35.h,
    buttonWidth: 138.h,
    borderRadius: BorderRadius.circular(22.h),
  );
}
