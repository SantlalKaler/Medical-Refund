import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/data_file.dart';
import '../../models/model_nearby_lab.dart';
import '../common/lab_list_view.dart';
import '../home/home_controller.dart';

class NearbyLabScreen extends StatefulWidget {
  const NearbyLabScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NearbyLabScreenState();
  }
}

class _NearbyLabScreenState extends State<NearbyLabScreen> {
  late final HomeController homeController;

  @override
  void initState() {
    homeController = Get.put(HomeController());
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  List<ModelNearbyLab> nearbyLabList = DataFile.nearbyLabList;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(20.h),
                getBackAppBar(
                  context,
                  () {
                    backClick();
                  },
                  AppLocalizations.of(context)!.nearbyLaboratories,
                ),
                getVerSpace(20.h),
                buildLabListView(homeController.searchData.value!, 'Lab')
              ],
            ),
          )),
    );
  }
}
