import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/sign_up/signup_controller.dart';
import '../../../base/color_data.dart';
import '../../../base/flutter_pin_code_fields.dart';
import '../../../base/widget_utils.dart';
import '../../dialog/account_created_dialog.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VerificationScreenState();
  }
}

class _VerificationScreenState extends State<VerificationScreen> {
  SignupController signupController = Get.put(SignupController());
  TextEditingController otpTextController = TextEditingController();

  @override
  void initState() {
    otpTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            getVerSpace(10.h),
            loginAppBar(() {}),
            getVerSpace(40.72.h),
            Expanded(
                child: Column(
              children: [
                loginHeader('Verify', 'Enter code sent to your phone number!'),
                getVerSpace(16.h),
                buildPinCodeFields(context),
                getVerSpace(40.h),
                buildVerifyButton(context),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Go back'))
              ],
            )),
            //buildResendButton(),
            getVerSpace(20.h)
          ],
        ).marginSymmetric(horizontal: 20.h),
      ),
    );
  }

  Widget buildResendButton() {
    return getRichText("Don't receive code? / ", Colors.black, FontWeight.w500,
        17.sp, "Resend", accentColor, FontWeight.w700, 17.sp, txtHeight: 1.41.h,
        function: () {
      signupController.registerUser();
    });
  }

  Widget buildVerifyButton(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) =>
            getButton(context, accentColor, 'Verify', Colors.white, () async {
              if (await signupController.verifyOtp(otpTextController.text)) {
                if (context.mounted) {
                  showDialog(
                      builder: (context) {
                        return const AccountCreatedDialog();
                      },
                      context: context);
                }
              }
            }, 18.sp,
                buttonHeight: 60.h,
                weight: FontWeight.w700,
                borderRadius: BorderRadius.circular(22.h)));
  }

  PinCodeFields buildPinCodeFields(BuildContext context) {
    return PinCodeFields(
      enabled: true,
      controller: otpTextController,
      autofocus: true,
      onComplete: (value) {},
      textStyle: buildTextStyle(context, Colors.black, FontWeight.w700, 24.sp),
      fieldHeight: 60.h,
      fieldWidth: 60.h,
      keyboardType: TextInputType.phone,
      length: 4,
      fieldBackgroundColor: fillColor,
      responsive: false,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      activeBorderColor: accentColor,
      fieldBorderStyle: FieldBorderStyle.square,
      // borderWidth: 1.h,
      borderRadius: BorderRadius.all(Radius.circular(22.h)),
      borderColor: fillColor,
    );
  }
}
