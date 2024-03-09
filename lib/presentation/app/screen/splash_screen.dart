import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/setting_controller.dart';

import '../../base/widget_utils.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  late SettingController controller;


  @override
  void initState() {
    super.initState();
    Get.delete<SettingController>();
    controller = Get.put(SettingController());
    controller.getSettings();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getAssetImage("logo.png", width: 146.2.h, height: 206.18.h)
          ],
        ),
      ),
    );
  }
}
