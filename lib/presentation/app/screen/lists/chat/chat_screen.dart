import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/presentation/app/screen/lists/chat/chat_controller.dart';
import 'package:lab_test_app/presentation/base/color_data.dart';
import '../../../../../data/app_urls.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../models/model_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  late ChatController chatController;

  @override
  void initState() {
    Get.delete<ChatController>();
    chatController = Get.put(ChatController());

    //here we get receiver id and receiver type
    var args = Get.arguments;
    chatController.setValue(args["receiverId"], args["receiverType"]);
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

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
            children: [
              getVerSpace(20.h),
              buildTopProfileView(context),
              buildChatWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatWidget(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          Constant.printValue(
              "Message list length is ${controller.messages.length}\n"
              " Message is ${controller.messages.isEmpty ? "empty" : controller.messages[0].type}\n"
              "${controller.messages.isEmpty ? "empty" : controller.messages[0].message}");
          return controller.loading.value
              ? showLoading()
              : Expanded(
                  child: Column(children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                          controller: controller.scrollController.value,
                          itemBuilder: (context, index) {
                            Radius radius = Radius.circular(22.h);
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                                  controller.messages[index].type == "send"
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                getVerSpace(12.h),
                                Container(
                                  padding: EdgeInsets.all(18.h),
                                  margin:
                                      controller.messages[index].type == "send"
                                          ? EdgeInsets.only(left: 39.h)
                                          : EdgeInsets.only(right: 39.h),
                                  decoration: BoxDecoration(
                                    color: controller.messages[index].type ==
                                            "send"
                                        ? '#F3EEFF'.toColor()
                                        : Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: radius,
                                        topRight: radius,
                                        bottomRight:
                                            controller.messages[index].type ==
                                                    "send"
                                                ? radius
                                                : Radius.zero,
                                        bottomLeft:
                                            controller.messages[index].type ==
                                                    "send"
                                                ? radius
                                                : Radius.zero),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x289a90b8),
                                        blurRadius: 32.h,
                                        offset: const Offset(0, 9),
                                      ),
                                    ],
                                  ),
                                  child: getMultilineCustomFont(
                                      controller.messages[index].message!,
                                      17.sp,
                                      Colors.black,
                                      fontWeight: FontWeight.w500,
                                      txtHeight: 1.7.h),
                                ),
                                getVerSpace(10.h),
                                //buildSeenRow(index),
                              ],
                            );
                          },
                          itemCount: controller.messages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            vertical: 18.h,
                          )),
                    ),
                    buildMessageTextField(context),
                    getVerSpace(20.h),
                  ]).marginSymmetric(horizontal: 20.h),
                );
        });
  }

  Row buildSeenRow(index) {
    /*var chatTime = "";
    var timeStamp = chatController.chats.value![index]['time'];
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    DateTime currentDate = DateTime.now();*/

    /* if (dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day) {
      chatTime =
          Constant.changeDateFormat(dateTime.toString(), changeInto: 'HH:mm');
    } else {
      chatTime = Constant.changeDateFormat(dateTime.toString(),
          changeInto: 'dd-MM-yyyy HH:mm');
    }*/

    return const Row(
      mainAxisAlignment: /* (chatController.chats.value![index]['sendby'] ==
              chatController.user.value?.name)
          ? MainAxisAlignment.end
          : */
          MainAxisAlignment.start,
      children: [
        /* getCustomFont(chatTime, 15.sp, greyFontColor, 1,
            fontWeight: FontWeight.w500),*/
        /* (chatController.chats.value![index]['sendby'] ==
                chatController.user.value?.name)
            ? getSvgImage("seen.svg",
                height: 20.h, width: 20.h, boxFit: BoxFit.fill)
            : getHorSpace(0.h),*/
      ],
    );
  }

  Widget buildMessageTextField(BuildContext context) {
    return getDefaultTextFiledWithLabel(
        context,
        AppLocalizations.of(context)!.typeAMessage,
        chatController.messageController.value,
        height: 60.h,
        isprefix: true,
        prefix: const Row(
          children: [
            /*
            getHorSpace(18.h),
            getSvgImage('camera.svg', height: 24.h, width: 24.h),
            getSvgImage('attach.svg', height: 24.h, width: 24.h)
                .paddingSymmetric(horizontal: 14.h),*/
          ],
        ),
        constraint: BoxConstraints(
          maxWidth: 20.h,
        ),
        withSufix: true,
        suffiximage: 'send_btn.svg', imagefunction: () {
      if (chatController.messageController.value.text != "") {
        chatController.onSendMessage();
      }
    }, suffixHeight: 52, suffixWidth: 52, suffixRightPad: 6);
  }

  Widget buildTopProfileView(BuildContext context) {
    var chatWith = chatController.receiverType.value;

    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Row(
            children: [
              getBackIcon(() {
                backClick();
              }),
              getCircularNetworkImage(
                  context,
                  54.h,
                  54.h,
                  22.h,
                  chatWith == ChatWith.lab.name
                      ? "${AppUrls.imageBaseUrl}${chatController.lab.value?.image}"
                      : (chatWith == ChatWith.user.name)
                          ? "${AppUrls.imageBaseUrl}${chatController.user.value?.image}"
                          : "${AppUrls.imageBaseUrl}${chatController.specialistDetails.value?.result?.detail?.image}",
                  boxFit: BoxFit.cover),
              getHorSpace(10.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getCustomFont(
                        chatWith == ChatWith.lab.name
                            ? chatController.lab.value?.name ?? ""
                            : (chatWith == ChatWith.user.name)
                                ? chatController.user.value?.name ?? ""
                                : chatController.specialistDetails.value?.result
                                        ?.detail?.name ??
                                    "",
                        16.sp,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w700),
                    Text('($chatWith)'),
                    getVerSpace(1.h),
                    /*getCustomFont(controller.userMap.value?['status'] ?? "Online", 15.sp, greyFontColor, 1,
                      fontWeight: FontWeight.w500),*/
                  ],
                ),
              ), /*
            getSvgImage('video.svg', height: 24.h, width: 24.h),
            getSvgImage('menu.svg', height: 24.h, width: 24.h)
                .paddingSymmetric(horizontal: 20.h),*/
            ],
          );
        });
  }
}
