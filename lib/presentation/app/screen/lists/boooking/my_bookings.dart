import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/BookingModel.dart';
import 'package:lab_test_app/presentation/app/screen/lists/boooking/booking_controller.dart';
import '../../../../base/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../base/widget_utils.dart';
import '../home_visit/my_home_visit_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyBookingScreenState();
  }
}

class MyBookingScreenState extends State<MyBookingScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late BookingController controller;/*
  List<ModelRecentSearch> recentSearchList = DataFile.recentSearchList;
  List<ModelNearbyLab> nearbyLabList = DataFile.nearbyLabList;*/

  @override
  void initState() {
    Get.delete<BookingController>();
    controller = Get.put(BookingController());
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {
                backClick();
              }, AppLocalizations.of(context)!.booking),
              getVerSpace(20.h),
              GetBuilder<BookingController>(
                  init: BookingController(),
                  builder: (controller) => (controller.loading.value)
                      ? showLoading()
                      : (controller.myBookingResponse.value != null)
                          ? buildVisitList(
                              controller.myBookings, context)
                          : getEmptyView())
            ],
          ),
        ),
      ),
    );
  }
}

Expanded buildBookingListView(List<Result> bookings) {
  return Expanded(
    child: ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        Result booking = bookings[index];
        return GestureDetector(
          onTap: () {
         /*   Constant.moveToNext(Routes.labDetailScreenRoute,
                arguments: "${booking.id}");*/
          },
          child: getShadowDefaultContainer(
            height: 450.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCircularNetworkImage(context, double.infinity, 106.h, 22.h,
                        "${AppUrls.imageBaseUrl}${booking.labs!.image}",
                        boxFit: BoxFit.fill)
                    .marginSymmetric(horizontal: 12.h),
                getVerSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont("Patient Info", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                getVerSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Name", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getCustomFont(booking.patientName!, 18.sp, Colors.grey, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getVerSpace(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont("Lab Info", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                getVerSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Name", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getCustomFont(booking.labs!.name!, 18.sp, Colors.grey, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getVerSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: getCustomFont("Address", 18.sp, Colors.black, 1,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: getMultilineCustomFont(booking.labs!.officeAddress!, 18.sp, Colors.grey,
                          fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                getVerSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Phone", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getCustomFont(booking.labs!.phone!, 18.sp, Colors.grey, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getVerSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getCustomFont("Test Info", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                getVerSpace(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Test", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getCustomFont(booking.testList!.title!, 18.sp, Colors.grey, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getVerSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Price", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                    getCustomFont("Rs. ${booking.price.toString()}", 18.sp, Colors.grey, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getVerSpace(20.h),
                //buildLocationRow(booking.labs!.officeAddress!, Get.width, 2),
              ],
            ).marginSymmetric(horizontal: 10.h),
          ),
        );
      },
    ),
  );
}
