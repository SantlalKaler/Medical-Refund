import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/BookingModel.dart';
import 'package:lab_test_app/presentation/app/screen/home/tab/tab_test_report.dart';
import 'package:lab_test_app/presentation/app/screen/lists/home_visit/my_home_visit_screen.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';
import '../../lists/boooking/booking_controller.dart';

class TabHomeVisit extends StatefulWidget {
  const TabHomeVisit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHomeVisitState();
  }
}

class _TabHomeVisitState extends State<TabHomeVisit> {
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

  TextEditingController searchController = TextEditingController();

  RxBool isVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(20.h),
        getBackAppBar(context, () {}, 'Home Visit', withLeading: false),
        getVerSpace(20.h),
        Expanded(
            child: Column(
          children: [
            /*
            getSearchTextFieldWidget(
                context, 56.h, 'Search your Location', searchController, (value) {}),
            getVerSpace(17.75.h),
            Expanded(
              child: buildBottomContainerWidget(context),
            ),*/
            GetBuilder<BookingController>(
                init: BookingController(),
                builder: (controller) {
                  return controller.loading.value
                      ? showLoading()
                      : bookingListView();
                }),
          ],
        ))
      ],
    );
  }

  Widget bookingListView() {
    var bookings = controller.bookings;
    if (controller.isSpecialist.value) {
      return bookings.isEmpty
          ? buildNoDataWidget(context)
          : buildVisitList(bookings, context, isSpecialist: true);
    } else {
      return bookings.isEmpty
          ? buildNoDataWidget(context)
          : (bookings[0].labs == null || bookings[0].testList == null)
              ? buildNoDataWidget(context)
              : buildVisitListTabHome();
    }
  }

  Expanded buildVisitListTabHome() {
    var homeVisitList = controller.bookings;
    return Expanded(
      child: ListView.builder(
        itemCount: homeVisitList.length,
        itemBuilder: (context, index) {
          Result homeVisit = homeVisitList[index];
          var lab = homeVisit.labs!;
          var test = homeVisit.testList!;
          return getShadowDefaultContainer(
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              padding: EdgeInsets.all(20.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     // getSvgImage('menu.svg', height: 24.h, width: 24.h)
                    ],
                  ),*/
                  getCustomFont(lab.name!, 16.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(3.h),
                  getCustomFont(lab.officeAddress!, 15.sp, Colors.black, 2,
                      fontWeight: FontWeight.w500),
                  getVerSpace(20.h),
                  getDivider(),
                  getVerSpace(20.h),
                  getCustomFont(test.title!, 16.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(3.h),
                  getCustomFont(test.shortDesc!, 15.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500),
                  getVerSpace(20.h),
                  buildDateTimeRow(
                      Constant.changeDateFormat(homeVisit.collectionDate!),
                      homeVisit.collectionSlot!),
                  getVerSpace(20.h),
                  buildVisitCompleteButton(homeVisit.collectionType! == 1
                      ? 'Home Visit'
                      : 'Lab Visit')
                ],
              ));
        },
      ),
    );
  }

  Widget buildVisitCompleteButton(title) {
    return getButton(
      context,
      'EFFAF0'.toColor(),
      title,
      "3CBC00".toColor(),
      () {},
      15.sp,
      weight: FontWeight.w500,
      buttonHeight: 35.h,
      buttonWidth: 138.h,
      borderRadius: BorderRadius.circular(22.h),
    );
  }
}

Container buildBottomContainerWidget(BuildContext context) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.h), topRight: Radius.circular(22.h)),
      image: DecorationImage(
        image: AssetImage('${Constant.assetImagePath}location_img.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildLocNavBtn(),
        getVerSpace(20.h),
        buildConfirmLocBtn(context),
        getVerSpace(80.h),
      ],
    ),
  );
}

Align buildLocNavBtn() {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      height: 50.h,
      width: 50.h,
      margin: EdgeInsets.only(right: 20.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: getSvgImage('situation.svg', height: 24.h, width: 24.h)),
    ),
  );
}

Widget buildConfirmLocBtn(BuildContext context) {
  return getButton(context, accentColor, 'Confirm Your Location', Colors.white,
          () {
    Constant.sendToNext(context, Routes.homeVisitScreenRoute);
  }, 18.sp,
          weight: FontWeight.w700,
          buttonHeight: 60.h,
          borderRadius: BorderRadius.all(Radius.circular(22.h)))
      .paddingSymmetric(horizontal: 20.h);
}

Column buildNoDataWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      getNoDataWidget(
          context,
          'No Booking Yet!',
          'Once you book, then \nyou see it listed here.',
          "no_home_visit_icon.svg",
          withButton: true,
          btnText: 'Go To Book Test', btnClick: () {
        Constant.sendToNext(context, Routes.testsListsScreenRoute);
        // isVisible.value = true;
      }),
      getVerSpace(100.h),
    ],
  );
}
