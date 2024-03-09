import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showSnackbar(title, message){
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, margin: EdgeInsets.all(20.h));
}