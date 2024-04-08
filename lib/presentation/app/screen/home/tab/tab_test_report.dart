import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/MyBookingResponse.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../controller/controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/data_file.dart';
import '../../../models/model_latest_report.dart';
import '../../lists/boooking/booking_controller.dart';

class TabTestReports extends StatefulWidget {
  const TabTestReports({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabTestReportsState();
  }
}

class _TabTestReportsState extends State<TabTestReports> {
  BottomItemSelectionController bottomController =
      Get.put(BottomItemSelectionController());

  List<ModelLatestReport> latestReportList = DataFile.latestReportList;

  late BookingController bookingController;

  @override
  void initState() {
    Get.delete<BookingController>();
    bookingController = Get.put(BookingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(20.h),
        getBackAppBar(context, () {},AppLocalizations.of(context)!.testReports, withLeading: false),
        getVerSpace(20.h),
        GetBuilder<BookingController>(
            init: BookingController(),
            builder: (controller) => controller.loading.value
                ? showLoading()
                : buildReportView(context, controller))
      ],
    );
  }

  Expanded buildReportView(BuildContext context, BookingController controller) {
    return Expanded(
      child: (controller.myBookings.isEmpty)
          ? buildNoTestReportView(context)
          : (controller.myBookings[0].test == null &&
                  controller.myBookings[0].labs == null &&
                  controller.myBookings[0].specialist == null)
              ? buildNoTestReportView(context)
              : buildLatestReportListView(controller),
    );
  }

  Column buildNoTestReportView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getNoDataWidget(
          context,
          AppLocalizations.of(context)!.noTestReportsYet,
          AppLocalizations.of(context)!.noTestReportDesc,
          "no_report_icon.svg",
          withButton: true,
          btnText: AppLocalizations.of(context)!.goToHome,
          btnClick: () {
            bottomController.bottomBarSelectedItem.value = 0;
          },
        ),
        getVerSpace(100.h),
      ],
    );
  }

  Widget buildContainerRow() {
    return Row(
      children: [
        buildTestContainer(
            'blood_bag.svg', 'Blood Group', 'A+', '#FFEDED'.toColor()),
        getHorSpace(20.h),
        buildTestContainer(
            'weighing_scale.svg', 'Weight', '20 kg', '#FFF4D8'.toColor()),
      ],
    ).paddingSymmetric(horizontal: 20.h);
  }

  Widget buildLatestReportListView(BookingController controller) {
    List<Booking> latestReportList = controller.myBookings;
    List<Booking> testReports = [];

    for (var report in latestReportList) {
      if (report.test != null &&
          report.test!.isNotEmpty &&
          report.report?.isNotEmpty == true) {
        testReports.add(report);
      }
    }

    return testReports.isEmpty
        ? buildNoTestReportView(context)
        : ListView.builder(
            shrinkWrap: true,
            itemCount: testReports.length,
            itemBuilder: (context, index) {
              Booking report = testReports[index];
              return InkWell(
                onTap: () {
                  //controller.setSelectedText(index);
                  //Constant.sendToNext(context, Routes.testReportScreenRoute);
                },
                child: getShadowDefaultContainer(
                    // height: 80.h,
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    padding: EdgeInsets.all(20.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            getCustomFont(
                                report.bookingId!, 17.sp, Colors.black, 1,
                                fontWeight: FontWeight.w500),
                            getHorSpace(12.h),
                            Expanded(
                                child: getCustomFont(
                                    report.test?[0].title ?? "",
                                    18.sp,
                                    Colors.black,
                                    1,
                                    fontWeight: FontWeight.w700)),
                            /*buildPopupMenuButton(
                        (value) {
                          handleClick(value);
                        },
                      )*/
                          ],
                        ),
                        getVerSpace(10.h),
                        Row(
                          children: [
                            getCustomFont(
                                'Beneficiary :', 15.sp, greyFontColor, 1,
                                fontWeight: FontWeight.w500),
                            getHorSpace(10.h),
                            getCustomFont(
                                report.labs!.name!, 17.sp, Colors.black, 1,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                        getVerSpace(14.h),
                        Row(
                          children: [
                            Expanded(
                                child: buildDateTimeRow(
                                    Constant.changeDateFormat(
                                        report.createdAt!),
                                    Constant.changeDateFormat(report.createdAt!,
                                        changeInto: "HH:mm"))),
                            report.report!.isEmpty
                                ? getEmptyView()
                                : InkWell(
                                    onTap: () {
                                      openUrl(
                                          "${controller.myBookingResponse.value!.pdfBaseURL}${report.report}");
                                    },
                                    child: getSvgImage('download.svg',
                                        width: 24.h, height: 24.h),
                                  ).marginSymmetric(horizontal: 20),
                          ],
                        ),
                      ],
                    )),
              );
            },
          );
  }

  void launchPDF(url) async {
    Constant.printValue("Url is $url");
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showSnackbar("Message", "Could not launch PDF");
      throw 'Could not launch PDF';
    }
  }

  openUrl(String url) async {
    Constant.printValue("Url : $url");
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not open the map.';
    }
  }

  PopupMenuButton<String> buildPopupMenuButton(
      PopupMenuItemSelected handleClick) {
    return PopupMenuButton<String>(
      onSelected: handleClick,
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.h))),
      elevation: 2.h,
      itemBuilder: (BuildContext context) {
        return {'Edit', 'Delete'}.map((String choice) {
          return PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            value: choice,
            height: 45.h,
            enabled: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getVerSpace(10.h),
                getCustomFont(choice, 15.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500)
                    .paddingSymmetric(horizontal: 14.h),
                (choice == 'Edit')
                    ? getDivider().paddingOnly(top: 20.h)
                    : getVerSpace(0),
              ],
            ),
          );
        }).toList();
      },
      child: getSvgImage('menu.svg', height: 24.h, width: 24.h),
    );
  }

  Expanded buildTestContainer(
      String icon, String title, String subtitle, Color color) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 76.h,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(22.h)),
          color: color,
        ),
        child: Row(
          children: [
            getIconContainer(60.h, 60.h, Colors.white, icon).paddingAll(8.h),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomFont(title, 15.sp, Colors.black, 1,
                    fontWeight: FontWeight.w500),
                getVerSpace(3.h),
                getCustomFont(subtitle, 22.sp, Colors.black, 1,
                    fontWeight: FontWeight.w800),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        break;
      case 'Delete':
        break;
    }
  }
}

Row buildDateTimeRow(String date, String time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          getSvgImage('calender.svg', height: 20.h, width: 20.h),
          getHorSpace(4.h),
          getCustomFont(date, 15.sp, greyFontColor, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
      if (time.isNotEmpty)
        Row(
          children: [
            getSvgImage('time.svg', height: 20.h, width: 20.h),
            getHorSpace(4.h),
            getCustomFont(time, 15.sp, greyFontColor, 1,
                fontWeight: FontWeight.w500),
          ],
        ),
    ],
  );
}

Row buildPaymentInfoRow(String bookingPrice, String totalPrice) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          getSvgImage('wallet_outline.svg', height: 20.h, width: 20.h),
          getHorSpace(4.h),
          getCustomFont(bookingPrice, 15.sp, greyFontColor, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getSvgImage('wallet_outline.svg', height: 20.h, width: 20.h),
          getHorSpace(4.h),
          getCustomFont(totalPrice, 15.sp, greyFontColor, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
    ],
  );
}

Row buildPaymentStatusRow(String paymentStatus, String bookingStatus) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          getSvgImage('booking_done.svg', height: 20.h, width: 20.h),
          getHorSpace(4.h),
          getCustomFont(bookingStatus, 15.sp, accentColor, 1,
              fontWeight: FontWeight.w500),
        ],
      ),
      if (paymentStatus.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSvgImage('card.svg', height: 20.h, width: 20.h),
            getHorSpace(4.h),
            getCustomFont(paymentStatus, 15.sp, greyFontColor, 1,
                fontWeight: FontWeight.w500),
          ],
        ),
    ],
  );
}
