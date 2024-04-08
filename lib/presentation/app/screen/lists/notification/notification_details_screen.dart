import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/lists/notification/notification_controller.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import 'package:lab_test_app/domain/model/NotificationModel.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationDetailsScreenState();
  }
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  NotificationController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.readNotification();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Result notification = controller
        .notifications!.value!.result![controller.selectedNotification.value];
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {
                backClick();
              }, 'Notification'),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (notification.from != null && notification.from!.isNotEmpty)
                      Text(
                        notification.from!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    getVerSpace(20.h),
                    Text(notification.message ?? "")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationList(List<Result> notificationList) {
    return ListView.separated(
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        Result notification = notificationList[index];
        return ListTile(
          onTap: () {},
          selected: (notification.read ?? false) ? false : true,
          title: (notification.from == null || notification.from!.isEmpty)
              ? const SizedBox.shrink()
              : Text(notification.from!),
          subtitle: Text(
            notification.message ?? "",
            maxLines: 2,
          ),
          trailing: Text(
            Constant.changeDateFormat(notification.createdAt!,
                changeInto: "dd/MM/yy, hh:mm"),
            style: const TextStyle(fontSize: 11),
          ),
        );
        return Row(
          children: [
            /*
                        getCircularImage(
                            context, 60.h, 60.h, 22.h, notification.img,
                            boxFit: BoxFit.cover),*/
            getHorSpace(10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*
                        getCustomFont(
                            notification.title, 16.sp, Colors.black, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(4.h),
                            */
                  getCustomFont(notification.message!, 15.sp, greyFontColor, 2,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            getHorSpace(10.h),
            getCustomFont(Constant.changeDateFormat(notification.createdAt!),
                15.sp, greyFontColor, 1,
                fontWeight: FontWeight.w500)
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return getDivider().marginSymmetric(vertical: 20.h);
      },
    ).marginSymmetric(horizontal: 20.h);
  }

  Column buildNoDataWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getNoDataWidget(
            context,
            'No Notifications Yet!',
            'We’ll notify you when something arrives.',
            'no_notification_icon.svg'),
        getVerSpace(100.h),
      ],
    );
  }
}
