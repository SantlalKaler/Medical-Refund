import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/presentation/app/screen/lists/specialist/specialist_controller.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';

class SpecialistDetailScreen extends StatefulWidget {
  const SpecialistDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SpecialistDetailScreenState();
  }
}

class _SpecialistDetailScreenState extends State<SpecialistDetailScreen> {
  late SpecialistController controller;
  GoogleMapController? mapController;

  @override
  void initState() {
    var labId = Get.arguments;
    Get.delete<SpecialistController>();
    controller = Get.put(SpecialistController());
    controller.getSpecialistDetails(labId);
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
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
          body: GetBuilder<SpecialistController>(
              init: SpecialistController(),
              builder: (controller) => controller.loading.value
                  ? showLoading()
                  : Column(children: [
                      buildTopProfileView(),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            // getVerSpace(26.h),
                            getCustomFont(
                                controller.specialistDetails.value!.result!
                                    .detail!.name!,
                                24.sp,
                                Colors.black,
                                1,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center),
                            getVerSpace(5.h),
                            getCustomFont(
                                controller.specialistDetails.value!.result!
                                    .detail!.education!,
                                17.sp,
                                greyFontColor,
                                1,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center),
                            getVerSpace(20.h),
                            buildSpecialistContactTab(),
                            getVerSpace(20.h),
                            buildSpecialistReviewRow(),
                            getVerSpace(30.h),
                            buildAboutSpecialistRow(context),
                            getVerSpace(24.h),
                            getCustomFont('Biography', 18.sp, Colors.black, 1,
                                fontWeight: FontWeight.w700),
                            getVerSpace(6.h),
                            buildDescView(),
                            getVerSpace(24.h),
                            buildTitleRow('Reviews', () {
                              Constant.sendToNext(
                                  context, Routes.labReviewsScreenRoute,
                                  arguments: {
                                    'specialist': controller.specialistDetails
                                        .value!.result!.detail!.id
                                  });
                            }, color: Colors.grey.withAlpha(30)),
                            getVerSpace(24.h),
                            buildLocationView(context),
                            buildMakeAppointmentButton(context)
                          ],
                        ).marginSymmetric(horizontal: 20.h),
                      )
                    ])),
        ));
  }

  Widget buildMakeAppointmentButton(BuildContext context) {
    return getButton(context, accentColor, "Make Appointment", Colors.white,
            () {
      Constant.sendToNext(context, Routes.addBookingScreenRoute, arguments: {
        'specialist': controller.specialistDetails.value!.result!.detail!
      });
    }, 18.sp,
            weight: FontWeight.w700,
            buttonHeight: 60.h,
            borderRadius: BorderRadius.circular(22.h))
        .marginSymmetric(vertical: 30.h);
  }

  Wrap buildLocationView(BuildContext context) {
    return Wrap(
      children: [
        getCustomFont('Location', 18.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(20.h),
        /*getCircularImage(context, double.infinity, 117.h, 22.h, 'loc.png',
            boxFit: BoxFit.cover)*/
        SizedBox(height: 200.h, width: double.infinity, child: buildMapView())
      ],
    );
  }

  Widget buildDescView() {
    return getMultilineCustomFont(
        Constant.removeHtmlTags(
          controller.specialistDetails.value!.result!.detail!.desc!,
        ),
        17.sp,
        greyFontColor,
        fontWeight: FontWeight.w500,
        txtHeight: 2.h);
  }

  Row buildAboutSpecialistRow(BuildContext context) {
    var details = controller.specialistDetails.value!.result!.detail!;
    return Row(
      children: [
        getTabContainer(
            context,
            'F9F8FF',
            'EDE8FE',
            Constant.getRuppee(details.priceBefore!),
            Constant.getRuppee(details.price!),
            showDiscountedPrice: true),
        getHorSpace(13.h),
        getTabContainer(context, '#FFF8F8', '#FEE8E8', 'Experience',
            '${details.expereance} Years'),
        getHorSpace(13.h),
        getTabContainer(
            context, 'FFFBF4', 'FDF1E7', 'Patients', details.totalPatients!)
      ],
    );
  }

  Widget buildMapView() {
    var lat = controller
        .specialistDetails.value!.result!.detail!.position!.coordinates!.first;
    var lng = controller
        .specialistDetails.value!.result!.detail!.position!.coordinates!.last;
    return GoogleMap(
      onMapCreated: (controller) {
        mapController = controller;
        mapController?.dispose();
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(lat.toDouble(), lng.toDouble()),
        zoom: 12,
      ),
      zoomControlsEnabled: false,
      onTap: (location) async {
        //_updateLoacation(location.latitude, location.longitude);
      },
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('selected-location'),
          position: LatLng(lat.toDouble(), lng.toDouble()),
        ),
      },
    );
  }

  Row buildSpecialistReviewRow() {
    var details = controller.specialistDetails.value?.result?.detail!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage('star.svg', height: 24.h, width: 24.h),
        getHorSpace(10.h),
        getRichText(
            details!.avgRating!.toString(),
            Colors.black,
            FontWeight.w500,
            17.sp,
            '(${details.totalRating} Reviews)',
            greyFontColor,
            FontWeight.w500,
            17.sp)
      ],
    );
  }

  Row buildSpecialistContactTab() {
    //var mobile = controller.specialistDetails.value.result.detail
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () => Constant.launchURL(
                "tel:${controller.specialistDetails.value!.result!.detail!.mobile!}"),
            child: getImageButtonWithSize('call.svg')),
        getHorSpace(10.h),
        InkWell(
            onTap: () => {
                  Constant.moveToNext(Routes.chatScreenRoute, arguments: {
                    'receiverId':
                        controller.specialistDetails.value!.result!.detail!.id!,
                    'receiverType': ChatWith.specialist.name
                  })
                },
            child: getImageButtonWithSize('chat.svg')),
        /*
        getHorSpace(20.h),
        getHorSpace(20.h),
        getImageButtonWithSize('video.svg'),*/
      ],
    );
  }

  Container buildTopProfileView() {
    return Container(
      height: 285.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: speBackColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22.h),
              bottomRight: Radius.circular(22.h))),
      child: Column(
        children: [
          getVerSpace(64.h),
          Stack(
            children: [
              getBackIcon(() {
                backClick();
              }),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: getNetworkImage(
                      "${controller.specialistDetails.value!.result!.imgBaseURL!}${controller.specialistDetails.value!.result!.detail!.image!}",
                      height: 221.h))
            ],
          ),
        ],
      ),
    );
  }
}

Widget getTabContainer(BuildContext context, String bgColor, String borderColor,
    String title, String subtitle,
    {bool showDiscountedPrice = false}) {
  return Expanded(
      child: Container(
    height: 78.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22.h)),
        color: bgColor.toColor(),
        border: Border.all(color: borderColor.toColor(), width: 1.w)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont(
          title,
          15.sp,
          showDiscountedPrice ? greyFontColor : Colors.black,
          1,
          decoration: showDiscountedPrice
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontWeight: FontWeight.w500,
        ),
        getVerSpace(6.h),
        getCustomFont(
          subtitle,
          16.sp,
          Colors.black,
          1,
          fontWeight: FontWeight.w700,
        ),
      ],
    ),
  ));
}
