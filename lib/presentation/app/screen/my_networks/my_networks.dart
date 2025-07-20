import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                }, AppLocalizations.of(context)!.myNetwork),
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
                              child: getCustomFont(
                                  AppLocalizations.of(context)!.noNetworkFound, 17.sp, greyFontColor, 1),
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
          return Padding(
            padding: const EdgeInsets.only(left : 10),
            child: Column(
              children: [
                getCircleNetworkImage(
                    context, "${AppUrls.imageBaseUrl}${user.user!.image}", 100.0),
                getVerSpace(4.h),
                getCustomFont(user.user!.name!, 18.sp, Colors.black, 1,
                    fontWeight: FontWeight.w700, txtHeight: 1.4.h),
                getVerSpace(4.h),
                getCustomFont(maskPhoneNumber(user.user!.mobile!), 15.sp, greyFontColor, 1,
                    fontWeight: FontWeight.w500, txtHeight: 1.4.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}

String maskPhoneNumber(String phoneNumber) {
  if (phoneNumber.length <= 4) {
    // If the length of the phone number is 4 or less, return the original number.
    return phoneNumber;
  }
  // Extract the first two characters and the last two characters.
  String prefix = phoneNumber.substring(0, 2);
  String suffix = phoneNumber.substring(phoneNumber.length - 2);

  // Replace characters between the first two and last two characters with asterisks.
  String maskedMiddle = phoneNumber.substring(2, phoneNumber.length - 2).replaceAll(RegExp(r'.'), '*');

  // Concatenate the prefix, masked middle, and suffix to form the masked phone number.
  String maskedPhoneNumber = '$prefix$maskedMiddle$suffix';

  return maskedPhoneNumber;
}

