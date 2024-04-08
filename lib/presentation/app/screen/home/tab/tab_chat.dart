import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/domain/model/MessageReceivedModel.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../models/model_profile.dart';
import '../../../routes/app_routes.dart';
import '../../lists/chat/chat_controller.dart';

class TabChat extends StatefulWidget {
  const TabChat({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabChatState();
  }
}

class _TabChatState extends State<TabChat> {
  final List<ModelProfile> allProfileList = DataFile.getAllProfileList();
  late ChatController chatController;

  @override
  void initState() {
    Get.delete<ChatController>();
    chatController = Get.put(ChatController());
    chatController.getUser();
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getVerSpace(20.h),
        getBackAppBar(context, () {
          backClick();
        }, AppLocalizations.of(context)!.chats, withLeading: false),
        getVerSpace(20.h),
        getSearchTextFieldWidget(context, 56.h, '${AppLocalizations.of(context)!.search}...', searchController,
            (value) {
          chatController.searchChatHeads(value);
        }),
        getVerSpace(20.h),
        buildChatList(context),
      ],
    );
  }

  Widget buildChatList(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) => (controller.loading.value)
            ? showLoading()
            : Expanded(
                child: (controller.chatHeads.value == null)
                    ? buildNoChatView(context)
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.filterChatHeads.isNotEmpty
                            ? controller.filterChatHeads.length
                            : controller.chatHeads.value?.result?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          MessageReceivedModel profile =
                              controller.filterChatHeads.isNotEmpty
                                  ? controller.filterChatHeads[index]
                                  : controller.chatHeads.value!.result![index];
                          var lab = profile.lab;
                          var specialist = profile.specialist;
                          var user = profile.users;
                          var isSpecialist = controller.isSpecialist.value;
                          return InkWell(
                            onTap: () {
                              Constant.sendToNext(
                                  context, Routes.chatScreenRoute,
                                  arguments: (isSpecialist)
                                      ? {
                                          "receiverType": ChatWith.user.name,
                                          "receiverId": user!.id
                                        }
                                      : (lab != null)
                                          ? {
                                              "receiverType": ChatWith.lab.name,
                                              "receiverId": lab.id
                                            }
                                          : {
                                              "receiverType":
                                                  ChatWith.specialist.name,
                                              "receiverId": specialist!.id
                                            });
                            },
                            child: Container(
                                height: 70.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 10.h),
                                child: Row(
                                  children: [
                                    getCircularNetworkImage(
                                        context,
                                        60.h,
                                        60.h,
                                        22.h,
                                        "${AppUrls.imageBaseUrl}${(isSpecialist) ? user!.image : (lab != null) ? lab.image : specialist!.image}",
                                        boxFit: BoxFit.cover),
                                    getHorSpace(12.h),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getCustomFont(
                                              "${(isSpecialist) ? user!.name : (lab != null) ? lab.name : specialist!.name}",
                                              16.sp,
                                              Colors.black,
                                              1,
                                              fontWeight: FontWeight.w700),
                                          getVerSpace(4.h),
                                          /* getCustomFont(
                                              'Lorem ipsum dolor sit amet, con...',
                                              15.sp,
                                              greyFontColor,
                                              1,
                                              fontWeight: FontWeight.w500)*/
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        getCustomFont(
                                            Constant.changeDateFormat(
                                                profile.createdAt!),
                                            15.sp,
                                            greyFontColor,
                                            1,
                                            fontWeight: FontWeight.w500),
                                        getVerSpace(4.h),
                                        /*(profile.currMsg != '0')
                                            ? Container(
                                                height: 24.h,
                                                width: 24.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: accentColor,
                                                ),
                                                child: Center(
                                                    child: getCustomFont(
                                                        profile.currMsg,
                                                        15.sp,
                                                        Colors.white,
                                                        1,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              )
                                            : Container(),*/
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                        /*separatorBuilder: (BuildContext context, int index) {
                          return getDivider(endIndent: 20.h, indent: 20.h);
                        }*/
                      ),
              ));
  }

  Column buildNoChatView(BuildContext context) {
    return Column(
      children: [
        getVerSpace(100.h),
        getNoDataWidget(
            context,
            'No Chats Yet!',
            'Once you start a new conversation, \nyou’ll see it listed here.',
            'no_chat_icon.svg'),
      ],
    );
  }
}
