import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/base/color_data.dart';

import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

Expanded buildLabListView(List<SearchData> dataList, String dataType) {
  return Expanded(
    child: ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        SearchData data = dataList[index];
        return GestureDetector(
          onTap: () {
            Constant.moveToNext(
                (dataType == 'Lab')
                    ? Routes.labDetailScreenRoute
                    : (dataType == 'Specialist')
                        ? Routes.specialistDetailScreenRoute
                        : Routes.testDetailScreenRoute,
                arguments:  data.id);
          },
          child: getShadowDefaultContainer(
            height: 130.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            color: Colors.white,
            child: Row(
              children: [
                getCircularNetworkImage(context, 106.h, 106.h, 22.h, data.image,
                        boxFit: BoxFit.fill)
                    .marginSymmetric(horizontal: 12.h),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(data.title, 18.sp, Colors.black, 1,
                          fontWeight: FontWeight.w700),
                      getVerSpace(5.h),
                      dataType == 'Lab'
                          ? buildLocationRow(data.subtitle, Get.width, 2)
                          : getCustomFont(
                              data.subtitle, 18.sp, greyFontColor, 1,
                              fontWeight: FontWeight.w500),
                    ],
                  ).marginSymmetric(horizontal: 4.h),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}

class SearchData {
  String id;
  String image;
  String title;
  String subtitle;

  SearchData(this.id, this.image, this.title, this.subtitle);
}
