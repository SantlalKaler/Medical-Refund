import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/lists/wallet/wallet_controller.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyWalletScreenState();
  }
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  late final WalletController controller;

  @override
  void initState() {
    super.initState();
    Get.delete<WalletController>();
    controller = Get.put(WalletController());
    controller.getUser();
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
              getBackAppBar(context, () {
                backClick();
              }, "Wallet"),
              GetBuilder<WalletController>(
                  init: WalletController(),
                  builder: (controller) => controller.loading.value
                      ? showLoading()
                      : Column(
                          children: [
                            buildWalletAmountView(context),
                            getVerSpace(20.h),
                            buildButtonView(context),
                            getVerSpace(30.h),
                            buildWalletTransaction(context)
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWalletAmountView(BuildContext context) {
    return getShadowDefaultContainer(
        width: double.infinity,
        color: Colors.grey.withOpacity(0.1),
        margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        padding: EdgeInsets.all(20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getSvgImage('wallet.svg',
                width: 100.h, height: 100.h, boxFit: BoxFit.cover),
            getHorSpace(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont("Wallet Amount", 18.sp, Colors.black, 1,
                    fontWeight: FontWeight.w700),
                getCustomFont(
                    "Rs. ${controller.wallet.value?.result?.totalAmount ?? '0'}",
                    18.sp,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w200),
              ],
            ),
          ],
        ));
  }

  Widget buildButtonView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getButton(
          context,
          accentColor,
          'Request Withdrawal',
          Colors.white,
          () {
            if (controller.wallet.value?.result?.totalAmount == null ||
                controller.wallet.value!.result!.totalAmount! < 500) {
              showSnackbar('Error',
                  'Amount must be more than Rs 500, You can only use this amount for bookings.');
              return;
            } else if (controller.user.value?.panNumber?.isEmpty == true) {
              showSnackbar('Error',
                  'Please upload or add your pan info in your profile.');
              return;
            }
            showDialog(
                context: context,
                builder: (context) {
                  return requestWithdrawalDialog();
                });
          },
          18.sp,
          weight: FontWeight.w700,
          buttonHeight: 30.h,
          buttonWidth: 200.h,
          borderRadius: BorderRadius.all(Radius.circular(10.h)),
        ),
        /*   getButton(
          context,
          accentColor,
          'Request Payout',
          Colors.white,
          () {},
          18.sp,
          weight: FontWeight.w700,
          buttonHeight: 30.h,
          buttonWidth: 150.h,
          borderRadius: BorderRadius.all(Radius.circular(10.h)),
        ),*/
      ],
    );
  }

  Widget buildWalletTransaction(BuildContext context) {
    var transactions = controller.wallet.value?.result?.transactions;

    return getShadowDefaultContainer(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            getCustomFont("Wallet Transactions", 20.sp, Colors.black, 1,
                fontWeight: FontWeight.w700),
            (transactions == null || transactions.isEmpty == true)
                ? Center(
                    heightFactor: 5.0,
                    child: getCustomFont(
                        "No transactions found", 20.sp, greyFontColor, 1,
                        fontWeight: FontWeight.w500),
                  )
                : DataTable(
                    horizontalMargin: 5,
                    columnSpacing: 30.w,
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Received')),
                      DataColumn(label: Text('Transfer')),
                      DataColumn(label: Text('Amount')),
                    ],
                    rows: transactions.map((transaction) {
                      var transactionIn =
                          transaction.type == "IN" ? true : false;
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            getCustomFont(
                                Constant.changeDateFormat(
                                    transaction.createdAt!),
                                14.sp,
                                greyFontColor,
                                1,
                                fontWeight: FontWeight.w500),
                          ),
                          DataCell(
                            getCustomFont(
                                transactionIn
                                    ? transaction.booking?.users?.name ?? ""
                                    : "",
                                14.sp,
                                greyFontColor,
                                1,
                                fontWeight: FontWeight.w500),
                          ),
                          DataCell(
                            getCustomFont(!transactionIn ? "Bank" : "", 14.sp,
                                greyFontColor, 1,
                                fontWeight: FontWeight.w500),
                          ),
                          DataCell(
                            getCustomFont(
                                "${transactionIn ? "+" : "-"}Rs. ${transaction.amount.toString()}",
                                14.sp,
                                greyFontColor,
                                1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    }).toList(),
                  )
          ],
        ));
  }

  requestWithdrawalDialog() {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.h),
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.h)),
        child: Container(
          padding: EdgeInsets.all(30.h),
          height: 200.h,
          child: Column(
            children: [
              getDefaultTextFiledWithLabel(
                context,
                "Enter withdrawal amount",
                controller.amountController.value,
                // height: 60.h,
                length: 10,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (email) {
                  if (email!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter amount';
                  }
                },
              ),
              getVerSpace(20.h),
              getButton(
                  context, accentColor, "Request Withdrawal", Colors.white, () {
                Get.back(closeOverlays: true);
                if (controller.amountController.value.text.isEmpty) {
                  showSnackbar("Alert", "Enter withdrawal amount");
                } else if (int.parse(controller.amountController.value.text) >
                    controller.wallet.value!.result!.totalAmount!) {
                  showSnackbar("Alert", "You do not have sufficent balance!");
                } else {
                  Constant.backToPrev();
                  controller.requestWithdrawals();
                }
              }, 18.sp,
                  weight: FontWeight.w700,
                  buttonHeight: 40.h,
                  borderRadius: BorderRadius.circular(22.h)),
            ],
          ),
        ));
  }
}
