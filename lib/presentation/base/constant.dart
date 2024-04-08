import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static bool isDriverApp = false;
  static const profilePic = 'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60';
  static const String fontsFamily = "Gilroy";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;
  static const String firebaseUserCollection = "users";
  static const String firebaseSpecialistCollection = "specialist";
  static const String firebaseLabCollection = "lab";
  static const String firebaseChatRoomCollection = "chatroom";

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static printValue(value) {
    print(
        " \n<================================\n $value \n=========================>\n\n");
  }

  static changeDateFormat(String date,
      {String format = 'dd MMM yyyy',
      String changeInto = 'dd MMM yyyy',
      bool upload = false}) {
    if (!upload) {
      String inputDate = date;
      DateTime parsedDate = DateTime.parse(inputDate);
      String formattedDate = DateFormat(changeInto).format(parsedDate);
      //printValue(" Input date: $date\nOutput date: $formattedDate");
      return formattedDate;
    } else {
      DateFormat inputFormat = DateFormat(format);
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');

      DateTime parsedDate = inputFormat.parse(date);
      String formattedDate = outputFormat.format(parsedDate);
      return formattedDate;
    }
  }

  static backToPrev({BuildContext? context}) {
    Get.back();
  }

  static getCurrency(BuildContext context) {
    return "ETH";
  }

  static sendToNext(BuildContext? context, String route, {Object? arguments}) {
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route);
    }
  }

  static moveToNext(String route, {Object? arguments}) {
    Constant.printValue("Argument is $arguments");
    if (arguments != null) {
      Get.toNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route);
    }
  }

  static moveToNextAndReplace(String route, {Object? arguments}) {
    if (arguments != null) {
      Get.offAndToNamed(route, arguments: arguments);
    } else {
      Get.offAndToNamed(route);
    }
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static sendToScreen(Widget widget, BuildContext context) {
    Get.to(widget);
  }

  static backToFinish(BuildContext context) {
    Get.back();
  }

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  static launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  static String removeHtmlTags(String htmlString) {
    RegExp htmlRegExp = RegExp(r'<[^>]*>|&[^;]+;', multiLine: true,caseSensitive: true);

    String cleanText = htmlString.replaceAll(htmlRegExp, ' ');
    return cleanText;
  }

  static String getRuppee(price){
    return '\u20B9 $price';
  }


}
