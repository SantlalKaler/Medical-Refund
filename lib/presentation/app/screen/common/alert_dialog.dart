// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:lab_test_app/presentation/base/constant.dart';
import 'package:lab_test_app/presentation/base/widget_utils.dart';

import '../../../base/color_data.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final isLogout;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.isLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        getButton(context, accentColor, "Ok", Colors.white, () {
          Constant.backToPrev();
        }, 18,
            weight: FontWeight.w700,
            buttonHeight: 60,
            borderRadius: BorderRadius.circular(22)),
      ],
    );
  }
}
