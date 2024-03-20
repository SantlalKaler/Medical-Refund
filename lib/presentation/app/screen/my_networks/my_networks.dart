import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/presentation/app/screen/my_networks/network_controller.dart';
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class MyNetworkScreen extends StatefulWidget {
  const MyNetworkScreen({Key? key}) : super(key: key);

  @override
  State<MyNetworkScreen> createState() => _MyNetworkScreenState();
}

class _MyNetworkScreenState extends State<MyNetworkScreen> {
  late final NetworkController controller;

  @override
  void initState() {
    Get.delete<NetworkController>();
    controller = Get.put(NetworkController());
    controller.getUser();
    super.initState();
  }

  void backClick(BuildContext context) {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getBackAppBar(context, () {
                  backClick(context);
                }, 'My Networks'),
              ],
            ),
            getVerSpace(20.h),
            /* buildHRView(context),
            getVerSpace(20.h),
            getCustomFont("Your team", 22.sp, Colors.black, 1,
                fontWeight: FontWeight.w700, txtHeight: 1.4.h),
            getVerSpace(20.h),*/
            GetBuilder<NetworkController>(
                init: NetworkController(),
                builder: (controller) {
                  return (controller.loading.value)
                      ? showLoading()
                      : (controller.networks.value?.result?.isEmpty == true)
                          ? Center(
                    heightFactor: 50.h,
                              child: getCustomFont(
                                  "No Network found", 17.sp, greyFontColor, 1),
                            )
                          : buildYourTeamView(context);
                }),
          ],
        ),
      ),
    );
  }

  Widget buildTopView(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont('Hierarchy', 18.sp, lightGreyColor, 1,
              fontWeight: FontWeight.w700),
          getVerSpace(7.h),
          Container(
            width: 40.w,
            height: 3,
            color: lightGreyColor,
          ),
        ],
      ),
      InkWell(
          onTap: () {
            Constant.backToPrev(context: context);
          },
          child: getSvgImage('close_circle.svg', height: 24.h, width: 24.h)),
    ]);
  }

  Widget buildHRView(BuildContext context) {
    return Column(
      children: [
        getVerSpace(10.h),
        getCustomFont("Sujata Shelke", 18.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(3.h),
        getCustomFont("HR Manager", 15.sp, lightGreyColor, 1,
            fontWeight: FontWeight.w500),
        getVerSpace(3.h),
        getCircleImage(context, "specialist1.png", 100.0),
        getVerticalLine(2.0, 40.0, Colors.grey),
        getCircleImage(context, "specialist1.png", 100.0),
        getVerSpace(10.h),
        getCustomFont("Sushma Avhad(You)", 18.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(3.h),
        getCustomFont("HR Executive", 15.sp, lightGreyColor, 1,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget buildYourTeamView(BuildContext context) {
    var network = controller.networks.value?.result;
    double margin = 5.h;
    int crossCount = 3;
    // if (context.isTablet) {
    //   crossCount = 3;
    // }
    double width = (MediaQuery.of(context).size.width - (margin * crossCount)) /
        crossCount;
    double height = 180.h;

    return Expanded(
      child: GridView.count(
        crossAxisCount: crossCount,
        crossAxisSpacing: margin,
        mainAxisSpacing: margin,
        childAspectRatio: width / height,
        children: List.generate(network!.length, (index) {
          var user = network[index];
          return Column(
            children: [
              getCircleNetworkImage(
                  context, "${AppUrls.imageBaseUrl}${user.user!.image}", 100.0),
              getVerSpace(4.h),
              getCustomFont(user.user!.name!, 18.sp, Colors.black, 1,
                  fontWeight: FontWeight.w700, txtHeight: 1.4.h),
              getVerSpace(4.h),
              getCustomFont(user.user!.email!, 15.sp, greyFontColor, 1,
                  fontWeight: FontWeight.w500, txtHeight: 1.4.h),
            ],
          );
        }),
      ),
    );
  }
}
