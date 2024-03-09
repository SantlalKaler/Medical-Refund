// ignore: library_prefixes
import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart' as bottombar;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/home/tab/tab_chat.dart';
import 'package:lab_test_app/presentation/app/screen/home/tab/tab_home_visit.dart';
import 'package:lab_test_app/presentation/app/screen/lists/profile/my_profile_screen.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';

import '../../../base/widget_utils.dart';
import '../../controller/controller.dart';
import '../../data/data_file.dart';
import '../../models/model_bottom_nav.dart';

class HomeScreenSpecialist extends StatefulWidget {
  const HomeScreenSpecialist({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenSpecialistState();
  }
}

class _HomeScreenSpecialistState extends State<HomeScreenSpecialist> with WidgetsBindingObserver {
  List<Widget> bottomViewList = [
    const TabHomeVisit(),
    const MyProfileScreen(),
    const TabChat(),
  ];


  List<ModelBottomNav> allBottomNavList = DataFile.bottomListForSpecialist;
  final controller = Get.put(BottomItemSelectionController());
 // final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("offline");
    }
    super.didChangeAppLifecycleState(state);
  }

  void setStatus(status) async {
    await PrefData.getUser();
    /*await firestore
        .collection(Constant.firebaseUserCollection)
        .doc(user!.id)
        .update({"status": status});*/
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return PopScope(
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Obx(() => bottomViewList[controller.bottomBarSelectedItem.value]
                /*controller.isSpecialist.value
                  ? bottomViewList[
                      controller.bottomBarSelectedItem.value]
                  : bottomViewList[controller.bottomBarSelectedItem.value]*/)),
          bottomNavigationBar: bottombar.ConvexAppBar.builder(
            onTap: (index) {
              controller.bottomBarSelectedItem.value = index;
            },
            onTapNotify: (index) {
              controller.bottomBarSelectedItem.value = index;
              return true;
            },
            // elevation: 1,
            count: allBottomNavList.length,
            /*
            count: controller.isSpecialist.value
                ? allBottomNavListSpecialist.length
                : allBottomNavList.length,*/
            backgroundColor: Colors.white,
            itemBuilder: Builder(),
            top: -45.h,
            // curveSize: 80.h,
            // curve: Curves.easeOut,
            initialActiveIndex: 0,
            height: 75.h,
          )),
    );
  }
}

class Builder extends bottombar.DelegateBuilder {
  List<ModelBottomNav> allBottomNavList = DataFile.bottomListForSpecialist;
  /*List<ModelBottomNav> allBottomNavListSpecialist =
      DataFile.bottomListForSpecialist;*/
  final controller = Get.put(BottomItemSelectionController());

  @override
  Widget build(BuildContext context, int index, bool active) {
    ModelBottomNav nav =  allBottomNavList[index];/*
    ModelBottomNav nav = controller.isSpecialist.value
        ? allBottomNavListSpecialist[index]
        : allBottomNavList[index];*/
   if (index == 1) {
      return Center(
        child: getSvgImage('profile_active.svg', width: 54.h, height: 54.h)
            .marginOnly(bottom: 47.h),
      );
    }
    /*if (index == 1 && controller.isSpecialist.value) {
      return Center(
        child: getSvgImage('home_visit.svg', width: 54.h, height: 54.h)
            .marginOnly(bottom: 47.h),
      );
    }*/
    return ObxValue(
        (p0) => getSvgImage(
              (controller.bottomBarSelectedItem.value == index)
                  ? nav.activeIcon
                  : nav.icon,
              width: 24.h,
              height: 24.h,
            ),
        controller.bottomBarSelectedItem);
  }

  @override
  bool fixed() {
    return true;
  }
}
