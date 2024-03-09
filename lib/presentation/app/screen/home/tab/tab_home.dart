import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';

import '../../../../../domain/model/HomeModel.dart';
import '../../../../../domain/model/Lab.dart';
import '../../../../../domain/model/specialist.dart';
import '../../../../../domain/model/test.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';
import '../home_controller.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabHomeState();
  }
}

class _TabHomeState extends State<TabHome> {
  late final HomeController homeController;

  @override
  void initState() {
    Get.delete<HomeController>();
    homeController = Get.put(HomeController());
    Get.put(LabController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        getVerSpace(20.h),
        buildTopProfileView(),
        getVerSpace(16.h),
        GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) => controller.loading.value
                ? showLoading()
                : Column(
                    children: [
                      controller.homeData.value?.sliders == null
                          ? getEmptyView()
                          : buildTopView(controller.homeData.value!.sliders!),
                      getVerSpace(20.h),
                      controller.settings.value == null
                          ? getEmptyView()
                          : Column(
                              children: [
                                buildTabView(),
                                !controller.settings.value!.result!.appSetting!
                                        .test!
                                    ? getEmptyView()
                                    : Column(
                                        children: [
                                          getVerSpace(24.h),
                                          // buildTitleRow(
                                          //     context, 'Tests Panel', () {
                                          //   // Constant.sendToNext(context,
                                          //   //     Routes.testsListsScreenRoute);
                                          // }),
                                          buildTestPanelView(controller
                                              .homeData.value!.tests!),
                                        ],
                                      ),
                                // controller.homeData.value?.labs == null &&
                                controller.homeData.value!.labs!.isEmpty
                                    ? getEmptyView()
                                    : (!controller.settings.value!.result!
                                            .appSetting!.labs!)
                                        ? getEmptyView()
                                        : Column(
                                            children: [
                                              const SizedBox(height: 16),
                                              buildViewAllView(context,
                                                  'Nearby Laboratories', () {
                                                Constant.sendToNext(
                                                    context,
                                                    Routes
                                                        .nearbyLabScreenRoute);
                                              }),
                                              buildNearbyLabView(controller
                                                  .homeData.value!.labs!),
                                            ],
                                          ),
                                // controller.homeData.value?.specialist == null &&
                                !controller.settings.value!.result!.appSetting!
                                        .specialist!
                                    ? getEmptyView()
                                    : (controller.homeData.value!.specialist!
                                            .isEmpty)
                                        ? getEmptyView()
                                        : Column(
                                            children: [
                                              buildViewAllView(
                                                  context, 'Top Specialist',
                                                  () {
                                                Constant.sendToNext(
                                                    context,
                                                    Routes
                                                        .topSpecialistScreenRoute);
                                              }),
                                              buildTopSpecialistView(controller
                                                  .homeData.value!.specialist!),
                                            ],
                                          ),
                              ],
                            ),
                      //controller.homeData.value?.tests == null &&
                      getVerSpace(50.h),
                    ],
                  )),
      ],
    );
  }

  SizedBox buildTopSpecialistView(List<Specialist> specialists) {
    return SizedBox(
      height: 142.h,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Constant.printValue("Id is ${specialists[index].id}");
              Constant.sendToNext(context, Routes.specialistDetailScreenRoute,
                  arguments: specialists[index].id);
            },
            child: Container(
              height: double.infinity,
              width: 124.h,
              margin: EdgeInsets.only(
                  left: (index == 0) ? 20.h : 9.h,
                  right: (index == 2) ? 20.h : 9.h,
                  bottom: 24.h,
                  top: 10.h),
              // margin: EdgeInsets.symmetric(horizontal: 20.h),
              decoration: BoxDecoration(
                  border: (index != 3)
                      ? Border(right: BorderSide(width: 2.h, color: fillColor))
                      : null),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: getCircleNetworkImage(
                        context, specialists[index].image!, double.infinity),
                  ),
                  getVerSpace(10.h),
                  getCustomFont(
                      specialists[index].name!, 16.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(3.h),
                  getCustomFont(
                      specialists[index].education!, 15.sp, greyFontColor, 1,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  buildTestPanelView(List<Test> tests) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (Test test in tests)
            GestureDetector(
              onTap: () {
                Constant.sendToNext(context, Routes.testDetailScreenRoute,
                    arguments: test.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 120,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //     child: getCircularNetworkImage(context, double.infinity,
                        //             double.infinity, 22.h, test.image!,
                        //             boxFit: BoxFit.cover)
                        //         .marginAll(10.h)),
                        getCustomFont(test.title ?? '', 18.sp, Colors.black, 2,
                            fontWeight: FontWeight.w700),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          test.shortDesc ?? ',',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // getVerSpace(5.h),
                        // const Divider(
                        //   color: Colors.black87,
                        // ),
                        // getVerSpace(5.h),
                        // getCustomFont(
                        //     test.adminCommission ?? '', 15.sp, Colors.black, 1,
                        //     fontWeight: FontWeight.w500),
                        // getVerSpace(10.h),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildTabView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        homeController.settings.value!.result!.appSetting!.test!
            ? getTabCell('#EEE5FF'.toColor(), 'test_icon.svg', 'Tests', () {
                Constant.sendToNext(context, Routes.testsListsScreenRoute);
              })
            : getEmptyView(),
        getHorSpace(20.h),
        homeController.settings.value!.result!.appSetting!.labs!
            ? getTabCell('#E2F4FF'.toColor(), 'lab_icon.svg', 'labs', () {
                Constant.sendToNext(context, Routes.nearbyLabScreenRoute);
              })
            : getEmptyView(),
        getHorSpace(20.h),
        //getTabCell('#FFEAFD'.toColor(), 'tip_icon.svg', 'Tips', () {}),
      ],
    ).marginSymmetric(horizontal: 20.h);
  }

  Expanded getTabCell(
      Color color, String icon, String title, Function function) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          width: 100.w,
          height: 62.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(30.h)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getHorSpace(5.h),
              Container(
                height: 54.h,
                width: 54.h,
                margin: EdgeInsets.symmetric(vertical: 5.h),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child:
                    Center(child: getSvgImage(icon, height: 24.h, width: 24.h)),
              ),
              // getHorSpace(10.h),
              Expanded(
                child: Center(
                    child: getCustomFont(title, 15.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500)),
              ),
              getHorSpace(10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopView(List<Sliders> sliders) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1.0,
      ),
      items: sliders.map((sliders) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 168.h,
              margin: EdgeInsets.symmetric(horizontal: 20.h),
              child: getNetworkImage(sliders.image!),
            );
          },
        );
      }).toList(),
    );
    /*return Container(
      height: 168.h,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22.h)),
        color: accentColor,
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: getMultilineCustomFont(
                        'Assured \nLaboratories', 20.sp, Colors.white,
                        fontWeight: FontWeight.w700,
                        txtHeight: 1.4.h,
                        overflow: TextOverflow.fade),
                  ),
                  getVerSpace(10.h),
                  Expanded(
                    flex: 1,
                    child: getMultilineCustomFont(
                        '100% Guaranteed \nResults', 15.sp, Colors.white,
                        fontWeight: FontWeight.w500,
                        txtHeight: 1.4.h,
                        overflow: TextOverflow.fade),
                  ),
                ],
              ).paddingOnly(left: 22.h).paddingSymmetric(vertical: 25.h)),
          Align(
              alignment: Alignment.bottomRight,
              child: getNetworkImage("https://images.unsplash.com/photo-1661956600684-97d3a4320e45?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8ZGV2ZWxvcGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60",
                  width: 258.h, boxFit: BoxFit.cover))
        ],
      ),
    );*/
  }

  Widget buildTopProfileView() {
    return Obx(() => homeController.user.value != null &&
                homeController.cities.value != null ||
            homeController.specialist.value != null
        ? Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont('Welcome', 22.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700),
                    getVerSpace(3.h),
                    getCustomFont(
                        homeController.isSpecialist.value
                            ? homeController.specialist.value!.name!
                            : homeController.user.value!.name!,
                        15.sp,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w500),
                  ],
                ),
              ),
              !homeController.isSpecialist.value
                  ? Row(
                      children: [
                        getCustomFont(homeController.defaultCity.value!.name!,
                            15.sp, Colors.black, 1,
                            fontWeight: FontWeight.w500),
                        getHorSpace(10.h),
                        buildPopupMenuButton((value) {
                          homeController.setDefaultCity(value);
                        },
                            homeController.cities.value!.result!
                                .map((e) => e.name!)
                                .toList(),
                            'location.svg'),
                        getHorSpace(15.h),
                        InkWell(
                            onTap: () {
                              Constant.sendToNext(
                                  context, Routes.searchScreenRoute);
                            },
                            child: getSvgImage('search.svg',
                                height: 24.h, width: 24.h)),
                        getHorSpace(15.h),
                      ],
                    )
                  : getEmptyView(),
              InkWell(
                onTap: () {
                  Constant.sendToNext(context, Routes.notificationScreenRoute);
                },
                child: getShadowDefaultContainer(
                    height: 50.h,
                    width: 50.h,
                    color: Colors.white,
                    child: Center(
                        child: getSvgImage('Notification.svg',
                            height: 24.h, width: 24.h))),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.h)
        : getEmptyView());
  }
}

SizedBox buildNearbyLabView(List<Lab> labs) {
  return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            for (var item in labs)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Constant.moveToNext(Routes.labDetailScreenRoute,
                        arguments: "${item.id}");
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        Image.network(
                          item.image ?? '',
                          height: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCustomFont(item.name!, 18.sp, Colors.black, 1,
                                fontWeight: FontWeight.w700),
                            getVerSpace(5.h),
                            buildLocationRow(item.officeAddress!, 100.h, 2),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
          ],
        ),
      )

      //  ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: labs.length,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       margin: EdgeInsets.only(
      //           left: (index == 0) ? 20.h : 9.h,
      //           right: (index == 2) ? 20.h : 9.h,
      //           bottom: 24.h,
      //           top: 10.h),
      //       child: GestureDetector(
      //         onTap: () {
      //           Constant.moveToNext(Routes.labDetailScreenRoute,
      //               arguments: "${labs[index].id}");
      //         },
      //         child: Card(
      //           child: Padding(
      //             padding: const EdgeInsets.all(16),
      //             child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   getCustomFont(labs[index].name!, 18.sp, Colors.black, 1,
      //                       fontWeight: FontWeight.w700),
      //                   getVerSpace(5.h),
      //                   buildLocationRow(labs[index].officeAddress!, 100.h, 2),
      //                 ]),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      );
}

Widget buildViewAllView(BuildContext context, String title, Function function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getCustomFont(title, 20.sp, Colors.black, 1, fontWeight: FontWeight.w700),
      GestureDetector(
        onTap: () {
          function();
        },
        child: getCustomFont(
          "View All",
          15.sp,
          accentColor,
          1,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  ).paddingSymmetric(horizontal: 20.h);
}
