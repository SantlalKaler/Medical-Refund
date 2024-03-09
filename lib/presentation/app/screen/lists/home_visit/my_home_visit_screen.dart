import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/BookingModel.dart';
import 'package:lab_test_app/presentation/base/color_data.dart';
import '../../../../../domain/model/test.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../models/model_home_visit.dart';
import '../../home/tab/tab_home_visit.dart';
import '../../home/tab/tab_test_report.dart';
import '../boooking/booking_controller.dart';
import '../tests/tests_lists_screen.dart';

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
                      : buildVisitList(controller.homeVisit, context);
                }),
          ],
        )),
      ),
    );
  }
}

Widget buildVisitList(List<Result> bookings, BuildContext context,
    {bool isSpecialist = false}) {
  return (bookings.isEmpty )
      ? Center(child: buildNoDataWidget(context))
      : Expanded(
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              Result homeVisit = bookings[index];
              var lab = homeVisit.labs;
              var specialist = homeVisit.specialist;
              var user = homeVisit.users!;

              Constant.printValue("Lab : ${homeVisit.labs}\n"
                  "Specialist : ${homeVisit.specialist}\n"
                  "user : ${homeVisit.users}");

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
                                  ? homeVisit.patientName!
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
                                  specialist?.officeAddress??"",
                          15.sp,
                          Colors.black,
                          2,
                          fontWeight: FontWeight.w500),
                      getVerSpace(20.h),
                      buildDateTimeRow(
                          Constant.changeDateFormat(homeVisit.collectionDate!),
                          homeVisit.collectionSlot!),
                      getVerSpace(20.h),
                      buildPaymentInfoRow(
                        homeVisit.price.toString(),
                        homeVisit.paymentGateway ?? ""
                      ),
                      getVerSpace(20.h),
                      if(homeVisit.test != null)
                        showTestInfo(homeVisit.test!)
                      // buildVisitCompleteButton(context)
                    ],
                  ));
            },
          ),
        );
}

Widget showTestInfo(Test test){
  return Column(
    children: [
      Container(
        width: 150,
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          borderRadius: SmoothBorderRadius.all(
              SmoothRadius(cornerRadius: 22.h, cornerSmoothing: 20.h)),
          color: "FFF4DF".toColor(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont(test.title ?? '', 18.sp, Colors.black, 3,
                fontWeight: FontWeight.bold),
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
