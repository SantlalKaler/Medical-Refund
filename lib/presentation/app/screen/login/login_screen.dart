import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../data/response_status.dart';
import '../../../base/color_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void backClick() {
    Constant.closeApp();
  }

  late final LoginController loginController;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.delete<LoginController>();
    loginController = Get.put(LoginController());
    loginController.getToken();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginController.changeBtnTxt(AppLocalizations.of(context)!.getOTP);
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        // backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formGlobalKey,
            child: Column(
              children: [
                getVerSpace(10.h),
                loginAppBar(() {
                  // backClick();
                }),
                getVerSpace(40.72.h),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        loginController.otpEnable.isFalse
                            ? loginHeader(AppLocalizations.of(context)!.logIn,
                                AppLocalizations.of(context)!.loginDesc)
                            : loginHeader(AppLocalizations.of(context)!.logIn,
          "${AppLocalizations.of(context)!.otpSentToYourMobile} ${loginController.mobileController.value.text}"),
                        getVerSpace(30.h),
                        buildTextFieldWidget(context),
                        getVerSpace(30.h),
                        buildLoginButton(context),
                        getVerSpace(31.h),
                        //buildOtherLogin()
                      ],
                    )),
                GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) => Column(
                          children: [
                            buildSignUpButton(),
                            getVerSpace(10.h),
                            buildLoginAsButton(),
                          ],
                        )),
                getVerSpace(20.h)
              ],
            ).marginSymmetric(horizontal: 20.h),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpButton() {
    return Visibility(
      visible: !loginController.isSpecialist.value,
      child: getRichText(
          "${AppLocalizations.of(context)!.ifYouAreNew} / ",
          Colors.black,
          FontWeight.w500,
          17.sp,
          AppLocalizations.of(context)!.createNewAccount,
          accentColor,
          FontWeight.w700,
          16.sp,
          txtHeight: 1.41.h, function: () {
        Constant.sendToNext(context, Routes.signUpRoute);
      }),
    );
  }

  Widget buildLoginAsButton() {
    return Obx(() => getRichText(
            "",
            Colors.black,
            FontWeight.w500,
            17.sp,
            !loginController.isSpecialist.value
                ? AppLocalizations.of(context)!.loginAsSpecialist
                : AppLocalizations.of(context)!.loginAsCustomer,
            accentColor,
            FontWeight.w700,
            16.sp,
            txtHeight: 1.41.h, function: () {
          loginController.changeUserType();
        }));
  }

  Column buildOtherLogin() {
    return Column(
      children: [
        getCustomFont("Or Log in with", 15.sp, Colors.black, 1,
            fontWeight: FontWeight.w500, txtHeight: 1.4.h),
        getVerSpace(20.h),
        Row(
          children: [
            getImageButton("phone.svg"),
            getHorSpace(18.h),
            getImageButton("facebook.svg"),
            getHorSpace(18.h),
            getImageButton("google.svg")
          ],
        )
      ],
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => controller.loading.value
          ? showLoading()
          : loginController.otpEnable.isFalse
              ? getButton(context, accentColor, AppLocalizations.of(context)!.getOTP,
                  Colors.white, () {
                  loginController.validate(context);
                }, 18.sp,
                  weight: FontWeight.w700,
                  buttonHeight: 60.h,
                  borderRadius: BorderRadius.circular(22.h))
              : getButton(context, accentColor, AppLocalizations.of(context)!.logIn,
                  Colors.white, () async {
                  await loginController.verifyOtp();
                }, 18.sp,
                  weight: FontWeight.w700,
                  buttonHeight: 60.h,
                  borderRadius: BorderRadius.circular(22.h)),
    );
  }

  Column buildTextFieldWidget(BuildContext context) {
    return Column(
      children: [
        GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) => !controller.otpEnable.value
              ? getDefaultTextFiledWithLabel(
                  context,
                  AppLocalizations.of(context)!.enterYourMobile,
                  loginController.mobileController.value,
                  // isEnable: !controller.otpEnable.value,
                  // height: 60.h,
                  length: 10,
                  keyboardType: TextInputType.phone,
                  // onChanged: ((value) =>
                  //     value.length == 10 ? loginController.validate() : null),
                  validator: (email) {
                    if (email!.isNotEmpty) {
                      return null;
                    } else {
                      return AppLocalizations.of(context)!.enterYourMobile;
                    }
                  },
                )
              : const SizedBox(),
        ),
        getVerSpace(20.h),
        GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) => controller.otpEnable.isTrue
              ? getDefaultTextFiledWithLabel(
                  context,
                  AppLocalizations.of(context)!.enterOtp,
                  loginController.otpController.value,
                  // isEnable: controller.otpEnable.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // height: 60.h,
                  validator: (password) {
                  if (password!.isNotEmpty) {
                    return null;
                  } else {
                    return null;
                  }
                })
              : const SizedBox.shrink(),
        ),
        getVerSpace(20.h),
        Obx(() =>
            loginController.otpEnable.isTrue && loginController.isResend.isTrue
                ? Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        loginController.isEnable();
                        loginController
                            .changeBtnTxt(AppLocalizations.of(context)!.getOTP);
                        loginController.otpController.value.clear();
                        loginController.isResend.toggle();
                      },
                      child: getCustomFont(
                          "${AppLocalizations.of(context)!.resendOrEdit}?",
                          16.sp,
                          accentColor,
                          1,
                          fontWeight: FontWeight.w700,
                          txtHeight: 1.5.h),
                    ),
                  )
                : loginController.otpEnable.isTrue
                    ? Countdown(
                        seconds: 20,
                        build: (BuildContext context, double time) => Text(
                            '${AppLocalizations.of(context)!.resendOrEdit} ${AppLocalizations.of(context)!.inWord} ${time.toStringAsFixed(0)}'),
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {
                          loginController.isResend.value = true;
                        },
                      )
                    : getEmptyView())
      ],
    );
  }
}
