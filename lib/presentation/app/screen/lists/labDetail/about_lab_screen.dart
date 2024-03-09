import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as parser;
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import 'lab_controller.dart';

class AboutLabScreen extends StatefulWidget {
  const AboutLabScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AboutLabScreenState();
  }
}

class _AboutLabScreenState extends State<AboutLabScreen> {
  late LabController controller;

  @override
  void initState() {
    controller = Get.put(LabController());
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                getVerSpace(20.h),
                getBackAppBar(context, () {
                  backClick();
                }, 'About Lab'),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(controller.image.value!))),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                      child: Text(parser
                          .parse(controller.lab.value!.description!)
                          .body!
                          .text),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
