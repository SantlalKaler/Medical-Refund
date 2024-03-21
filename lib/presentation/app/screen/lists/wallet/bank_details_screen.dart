import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/lists/profile/profile_controller.dart';
import 'package:lab_test_app/presentation/app/screen/lists/wallet/wallet_controller.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BankDetailsScreenState();
  }
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                getVerSpace(20.h),
                getBackAppBar(context, () {
                  backClick();
                }, "Bank Details"),
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (profileController) {
                    if (profileController.user.value == null) profileController.getUser();
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formGlobalKey,
                        child: Column(
                          children: [
                            getDefaultTextFiledWithLabel(
                              context,
                              "Bank Name",
                              profileController.bankNameController.value,
                              height: 60.h,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter bank name';
                                }
                              },
                            ),
                            getVerSpace(20.h),
                            getDefaultTextFiledWithLabel(
                              context,
                              "A/C Number",
                              profileController.accNumberController.value,
                              height: 60.h,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter account number';
                                }
                              },
                            ),
                            getVerSpace(20.h),
                            getDefaultTextFiledWithLabel(
                              context,
                              "A/C Holder",
                              profileController.accHolderNameController.value,
                              height: 60.h,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter account holder name';
                                }
                              },
                            ),
                            getVerSpace(20.h),
                            getDefaultTextFiledWithLabel(
                              context,
                              "IFSC",
                              profileController.ifscCodeController.value,
                              height: 60.h,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Please enter IFSC code';
                                }
                              },
                            ),
                            getVerSpace(40),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: profileController.loading.value
                                    ? showLoading()
                                    : getButton(
                                        context,
                                        accentColor,
                                        'Save',
                                        Colors.white,
                                        () {
                                          if (formGlobalKey.currentState!
                                              .validate()) {
                                            profileController.updateProfile();
                                          }
                                        },
                                        18.sp,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(22.h)),
                                        buttonHeight: 60.h,
                                      ).marginSymmetric(horizontal: 20.h)),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
