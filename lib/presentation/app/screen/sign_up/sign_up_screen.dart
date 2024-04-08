import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/sign_up/signup_controller.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void backClick() {
    Constant.sendToNext(context, Routes.loginRoute);
  }

  final signUpGlobalKey = GlobalKey<FormState>();

  RxBool agreeTerm = false.obs;

  late final SignupController signupController;

  @override
  void initState() {
    Get.delete<SignupController>();
    signupController = Get.put(SignupController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return PopScope(
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: signUpGlobalKey,
            child: Column(
              children: [
                getVerSpace(10.h),
                loginAppBar(() {}),
                getVerSpace(40.72.h),
                Expanded(
                    child: Column(
                  children: [
                    loginHeader(AppLocalizations.of(context)!.signUp,
                        AppLocalizations.of(context)!.signupDesc),
                    getVerSpace(30.h),
                    buildTextFieldWidget(context),
                    getVerSpace(40.h),
                    buildSignupButton(context),
                    // getVerSpace(42.h),
                  ],
                )),
                buildLoginButton(context),
                getVerSpace(20.h)
              ],
            ).marginSymmetric(horizontal: 20.h),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return getRichText("${AppLocalizations.of(context)!.alreadyHaveAnAccount} / ", Colors.black,
        FontWeight.w500, 17.sp, AppLocalizations.of(context)!.logIn, accentColor, FontWeight.w700, 16.sp,
        txtHeight: 1.41.h, function: () {
      Constant.sendToNext(context, Routes.loginRoute);
    });
  }

  Widget buildSignupButton(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) => controller.loading.value
            ? showLoading()
            : getButton(context, accentColor, AppLocalizations.of(context)!.signUp, Colors.white, () {
                if (signUpGlobalKey.currentState!.validate()) {
                  signupController.validate();
                }
                //Constant.sendToNext(context, Routes.verificationRoute);
              }, 18.sp,
                weight: FontWeight.w700,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(22.h)));
  }

  Column buildTextFieldWidget(BuildContext context) {
    return Column(
      children: [
        getDefaultTextFiledWithLabel(
          context,
          AppLocalizations.of(context)!.enterFullName,
          signupController.nameController.value,
          // height: 60.h,
          validator: (email) {
            if (email!.isNotEmpty) {
              return null;
            } else {
              return AppLocalizations.of(context)!.enterFullName;
            }
          },
        ),
        getVerSpace(20.h),
        getDefaultTextFiledWithLabel(context, AppLocalizations.of(context)!.enterphonenumber,
            signupController.phoneController.value,
            // height: 60.h,
            isprefix: true,
            length: 10,
            validator: (value) {
              if (value!.isNotEmpty && value.length == 10) {
                return null;
              } else {
                return AppLocalizations.of(context)!.enterphonenumber;
              }
            },
            /*prefix: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.selectCountryRoute);
              },
              child: Row(
                children: [
                  getHorSpace(18.h),
                  getAssetImage(controller.image.value),
                  getHorSpace(10.h),
                  getCustomFont(controller.code.value, 15.sp, skipColor, 1,
                      fontWeight: FontWeight.w400),
                  getHorSpace(10.h),
                  getSvgImage("arrow_down.svg", width: 24.h, height: 24.h),
                ],
              ),
            ),*/
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
            ],
            constraint: BoxConstraints(maxWidth: 120.h, maxHeight: 24.h),
            keyboardType: TextInputType.phone),
        getVerSpace(20.h),
        getDefaultTextFiledWithLabel(
          context,
          AppLocalizations.of(context)!.referralCode,
          signupController.referralCodeController.value,
          // height: 60.h,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
          // ],
          // keyboardType: TextInputType.phone,
        ),
        getVerSpace(20.h),
        getVerSpace(20.h),
        Row(
          children: [
            GetBuilder<SignupController>(
              builder: (controller) => Checkbox(
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: checkBox, width: 1.h),
                activeColor: accentColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.h))),
                onChanged: (value) {
                  controller.isAgree();
                },
                value: controller.agreeTerm.value,
              ),
            ),
            // getHorSpace(10.h),
            getCustomFont(
                AppLocalizations.of(context)!.iagreewithTermsAndCondition, 17.sp, Colors.black, 1,
                fontWeight: FontWeight.w500),
          ],
        ),
      ],
    );
  }
}
