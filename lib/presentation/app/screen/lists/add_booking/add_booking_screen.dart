import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';
import 'package:lab_test_app/presentation/app/screen/lists/tests/test_detail_screen.dart';

import '../../../../../domain/model/LabDetailsModel.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../tests/tests_lists_screen.dart';
import 'add_booking_controller.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddBookingScreenState();
  }
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late final AddBookingController controller;
  final formGlobalKey = GlobalKey<FormState>();

  num testPendingAmount = 0;
  num testBookingPrice = 0;

  LabController labController = Get.find();

  @override
  void initState() {
    super.initState();
    Get.delete<AddBookingController>();
    controller = Get.put(AddBookingController());
    var args = Get.arguments;
    if (args != null) {
      Constant.printValue(args);
      if (args.containsKey('specialist')) {
        controller.specialist.value = (args['specialist']);
      } else if (args.containsKey('priceList')) {
        controller.test.value = args['test'];
        controller.priceList.value = args['priceList'];
      } else if (args.containsKey('multiTests')) {
        controller.multiTests.value = true;
      } else {
        controller.test.value = args['test'];
        controller.lab.value = args['lab'];
        controller.testAdminCommission.value = args['adminCommission'] == null
            ? 0
            : int.parse(args['adminCommission'].toString());
      }
    }
  }

  List visit = ['Visit Lab', 'Visit Home'];

  @override
  Widget build(BuildContext context) {
    bool isTestBooking = (controller.specialist.value == null &&
        controller.priceList.value == null);

    // when data come from lab details page to book
    if (controller.multiTests.isTrue) {
      for (var test in labController.selectedTests) {
        Constant.printValue("TEst Price : ${test.test?.price}");
        var amount = test.price! - (test.adminCommission ?? 0);
        testPendingAmount += amount;
        testBookingPrice += test.priceBefore!;
      }
    }

    dynamic pendingAmount = (controller.specialist.value != null)
        ? controller.specialist.value!.price! -
        controller.specialist.value!.adminCommission!
        : (controller.priceList.value != null)
        ? controller.priceList.value!.price! -
        controller.priceList.value!.adminCommission!
        : (controller.multiTests.isTrue)
        ?testPendingAmount
        : (controller.test.value!.price!) -
        controller.testAdminCommission.value;

    dynamic bookingPrice = (controller.specialist.value != null)
        ? controller.specialist.value!.adminCommission!
        : (controller.priceList.value != null)
        ? controller.priceList.value!.adminCommission
        : (controller.priceList.value != null)
        ? controller.test.value!.adminCommission!
        : (controller.multiTests.isTrue)
        ? testBookingPrice
        : (controller.test.value!.priceBefore!);

    initializeScreenSize(context);
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
              }, 'Add Booking'),
              getVerSpace(20.h),
              Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                          controller.specialist.value == null
                              ? 'Test'
                              : 'Specialist',
                          18.sp,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w700)
                          .marginSymmetric(horizontal: 20.h),
                      getVerSpace(12.h),
                      buildTestInfoView(),
                      getVerSpace(20.h),
                      Obx(
                            () =>
                        controller.selectedPos.value == 1
                            ? buildInfoWidget()
                            : getEmptyView(),
                      ),
                      getVerSpace(20.h),
                      controller.specialist.value == null
                          ? buildVisitWidget()
                          : getEmptyView(),
                      getVerSpace(20.h),
                      controller.specialist.value == null
                          ? buildSelectedLabView()
                          : getEmptyView(),
                      getVerSpace(20.h),
                      buildTotalAmountRow(bookingPrice, pendingAmount,
                          isTestBooking: isTestBooking),
                      getVerSpace(20.h),
                      buildPlaceOrderButton(
                          context,
                          isTestBooking ? pendingAmount : bookingPrice),
                      getVerSpace(20.h),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectedLabView() {
    var selectedLab = controller.priceList.value;
    var lab = controller.lab.value;
    return buildSingleLabView(
        context,
        controller.multiTests.isTrue
            ? AppUrls.imageBaseUrl + labController.lab.value!.image!
            : selectedLab?.labImage ?? AppUrls.imageBaseUrl + lab!.image!,
        controller.multiTests.isTrue
            ? labController.lab.value!.name!
            : selectedLab?.labName ?? lab?.name,
        controller.multiTests.isTrue
            ? labController.lab.value!.officeAddress!
            : selectedLab?.officeAddress ?? lab?.officeAddress);
  }

  Widget buildTestInfoView() {
    var specialist = controller.specialist.value;
    var test = controller.test.value;
    var colorList = DataFile.colorList;

    final random = Random();

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    if (controller.multiTests.isTrue) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        padding: const EdgeInsets.only(left: 10, right: 10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: height / (width * 1.5),
        children:
        List.generate(labController.selectedTests.length, (index) {
          Tests test = labController.selectedTests[index];
          return singleTestView(test, () {},
              colorList[random.nextInt(colorList.length)].toColor());
        }),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: getCustomFont(
                specialist == null ? test!.test!.title! : specialist.name!,
                22.h,
                Colors.black,
                3,
                fontWeight: FontWeight.w700),
          ),
        ],
      ).marginSymmetric(horizontal: 20.h);
    }
  }

  Widget buildPlaceOrderButton(BuildContext context, bookinAmount) {
    Constant.printValue("Booking Amount in button $bookinAmount");
    return GetBuilder<AddBookingController>(
        init: AddBookingController(),
        builder: (controller) {
          return controller.loading.value
              ? showLoading()
              : getButton(
            context,
            accentColor,
            'Place Order',
            Colors.white,
                () {
              if (controller.selectedPos.value == 1 &&
                  formGlobalKey.currentState!.validate()) {
                //controller.addBooking();
                controller.createPayment(bookinAmount);
              }
              if (controller.selectedPos.value == 0) {
                controller.createPayment(bookinAmount);
                //controller.addBooking();
              }
            },
            18.sp,
            weight: FontWeight.w700,
            buttonHeight: 60.h,
            borderRadius: BorderRadius.circular(22.h),
          ).marginSymmetric(horizontal: 20.h);
        });
  }

  // Widget buildDateTimeWidget(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       getCustomFont('Collection Date & Time', 16.sp, Colors.black, 1,
  //           fontWeight: FontWeight.w700),
  //       getVerSpace(10.h),
  //       Form(
  //         autovalidateMode: AutovalidateMode.onUserInteraction,
  //         key: formGlobalKey,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(
  //                 flex: 1,
  //                 child: getDefaultTextFiledWithLabel(
  //                     context, "Select Date", controller.dateController.value,
  //                     withSufix: true,
  //                     suffiximage: 'calender.svg',
  //                     validator: (date) {
  //                       if (date!.isNotEmpty) {
  //                         return null;
  //                       } else {
  //                         return 'Please select date';
  //                       }
  //                     },
  //                     keyboardType: TextInputType.none,
  //                     isReadonly: true,
  //                     imagefunction: () {
  //                       Get.bottomSheet(
  //                         SfDateRangePicker(
  //                           onSelectionChanged: (v) {},
  //                           selectionMode: DateRangePickerSelectionMode.single,
  //                           initialSelectedRange: PickerDateRange(
  //                               DateTime.now()
  //                                   .subtract(const Duration(days: 4)),
  //                               DateTime.now().add(const Duration(days: 3))),
  //                         ),
  //                       );
  //                     })),
  //             getHorSpace(20.h),
  //             // Expanded(
  //             //     flex: 1,
  //             //     child: getDefaultTextFiledWithLabel(
  //             //         context, "Select Time", controller.timeController.value,
  //             //         withSufix: true,
  //             //         suffiximage: 'time.svg', validator: (time) {
  //             //       if (time!.isNotEmpty) {
  //             //         return null;
  //             //       } else {
  //             //         return 'Please select time';
  //             //       }
  //             //     }, imagefunction: () {
  //             //       getCalenderBottomSheet(context, 'Select Date', 'Save',
  //             //           (dob) {
  //             //         //profileController.changeDob(dob);
  //             //       });
  //             //     }))
  //           ],
  //         ),
  //       ),
  //       getVerSpace(20.h),
  //     ],
  //   ).marginSymmetric(horizontal: 20.h);
  // }

  Widget buildVisitWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont('Visit', 16.sp, Colors.black, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(10.h),
        Row(
            children: List.generate(2, (index) {
              return Row(
                children: [
                  ObxValue(
                          (p0) =>
                          InkWell(
                            onTap: () {
                              controller.selectedPos.value = index;
                            },
                            child: (controller.selectedPos.value == index)
                                ? getSvgImage('radio_checked.svg',
                                height: 24.h, width: 24.h)
                                : getSvgImage('radio_unchecked.svg',
                                height: 24.h, width: 24.h),
                          ),
                      controller.selectedPos),
                  getHorSpace(10.h),
                  getCustomFont(visit[index], 17.sp, Colors.black, 1,
                      fontWeight: FontWeight.w500)
                      .paddingOnly(right: 32.h)
                ],
              );
            })),
      ],
    ).marginSymmetric(horizontal: 20.h);
  }

  Widget buildInfoWidget() {
    // var lab = controller.selectedLab.value;
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formGlobalKey,
      child: getShadowDefaultContainer(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*getCustomFont('Beneficiary Information', 18.sp, Colors.black, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(12.h),
            getDivider(),
            getVerSpace(16.h),*/
            /*
            getCustomFont('name', 15.sp, greyFontColor, 1,
                fontWeight: FontWeight.w500),*/
            /*getVerSpace(5.h),
            getDefaultTextFiledWithLabel(
              context,
              "Enter patient name",
              controller.nameController.value,
              keyboardType: TextInputType.name,
              validator: (name) {
                if (name!.isNotEmpty) {
                  return null;
                } else {
                  return 'Please enter patient name';
                }
              },
            ),
            getVerSpace(10.h),
            */
            /*
            getCustomFont('Address', 15.sp, greyFontColor, 1,
                fontWeight: FontWeight.w500),*/
            getVerSpace(5.h),
            getDefaultTextFiledWithLabel(
              context,
              "Enter address",
              controller.addressController.value,
              keyboardType: TextInputType.name,
              validator: (address) {
                if (address!.isEmpty && controller.selectedPos.value == 1) {
                  return 'Please enter address';
                } else {
                  return null;
                }
              },
            ),
            getVerSpace(6.h),
            getCustomFont('Collection Date & Time', 16.sp, Colors.black, 1,
                fontWeight: FontWeight.w700),
            getVerSpace(12.h),
            getDivider(),
            getVerSpace(12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: getDefaultTextFiledWithLabel(
                        context, "Select Date", controller.dateController.value,
                        withSufix: true,
                        isReadonly: true,
                        suffiximage: 'calender.svg',
                        validator: (date) {
                          if (date!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please select date';
                          }
                        },
                        keyboardType: TextInputType.none,
                        imagefunction: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2300),
                          );
                          if (picked != null) {
                            controller.dateController.value.text =
                                Constant.changeDateFormat(picked.toString());
                          }
                          // getCalenderBottomSheet(context, 'Select Date', 'Save',
                          //     maxDate: DateTime(2300),
                          //     minDate: DateTime.now(), (dob) {
                          //   controller.dateController.value.text =
                          //       Constant.changeDateFormat(dob);
                          // });
                        })),
                getHorSpace(20.h),
                Expanded(
                    flex: 1,
                    child: getDefaultTextFiledWithLabel(
                        context, "Select Time", controller.timeController.value,
                        withSufix: true,
                        isReadonly: true,
                        keyboardType: TextInputType.none,
                        suffiximage: 'time.svg',
                        validator: (time) {
                          if (time!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please select time';
                          }
                        },
                        imagefunction: () {
                          getTimeBottomSheet(context, (time) {
                            controller.timeController.value.text =
                                Constant.changeDateFormat(time.toString(),
                                    changeInto: "HH:mm");
                          });
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
