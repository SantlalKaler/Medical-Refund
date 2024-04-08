
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../base/locals.dart';
import '../controller/settings_controller.dart';

Widget selectLanguage(BuildContext context) {
  SettingsController settingsController = Get.find();
  List languages = [
    //0
    {
      'title': 'English',
      'local': AppLocals.english,
    },
    // 1
    {
      'title': 'Hindi',
      'local': AppLocals.hindi,
    },
    // 2
    {
      'title': 'Punjabi',
      'local': AppLocals.punjabi,
    },
  ];
  Locale? currentLocal = Get.locale;

  return SizedBox(
    width: double.infinity,
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Gap(20),
          Text(
            'Select Language',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(20),
          for (var item in languages)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  selected:
                      currentLocal?.languageCode == item['local'].languageCode,
                  title: Text(
                    item['title'],
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    settingsController.updateAppLanguage(item['local']);
                    Get.back(result: true);
                  }),
            ),
          const Gap(20),
        ],
      ),
    ),
  );
}
