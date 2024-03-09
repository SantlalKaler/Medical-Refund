import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/screen/common/lab_list_view.dart';
import 'package:lab_test_app/presentation/app/screen/lists/search/search_controller.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/data_file.dart';
import '../../../models/model_nearby_lab.dart';
import '../../../models/model_recent_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late SearcController controller;
  List<ModelRecentSearch> recentSearchList = DataFile.recentSearchList;
  List<ModelNearbyLab> nearbyLabList = DataFile.nearbyLabList;

  @override
  void initState() {
    Get.delete<SearcController>();
    controller = Get.put(SearcController());
    controller.changeSearchByValue('Lab');
    super.initState();
  }

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
              /*getBackAppBar(context, () {
                backClick();
              }, 'Search For Lab', ),*/
              buildAppBar(),
              getVerSpace(20.h),
              getSearchTextFieldWidget(
                  context, 60.h, 'search...', controller.searchController.value,
                  (value1) {
                if (value1 != "") {
                  controller.validate();
                }
              }),
              /*getVerSpace(20.h),
              getCustomFont('Recent Searches', 16.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700)
                  .paddingSymmetric(horizontal: 20.h),
              getVerSpace(14.h),
              buildRecentSearchTab(),*/
              getVerSpace(30.h),
              /* buildViewAllView(context, 'Nearby Laboratories', () {
                Constant.sendToNext(context, Routes.nearbyLabScreenRoute);
              }),*/
              //buildNearbyLabView(),
              GetBuilder<SearcController>(
                  init: SearcController(),
                  builder: (controller) => (controller.loading.value)
                      ? showLoading()
                      : (controller.searchData.value != null)
                          ? buildLabListView(controller.searchData.value!,
                              controller.searchByValue.value)
                          : getEmptyView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultView() {
    return Column(
      children: [
        (controller.loading.value)
            ? showLoading()
            : (controller.searchData.value != null)
                ? buildLabListView(controller.searchData.value!,
                    controller.searchByValue.value)
                : getEmptyView()
      ],
    );
  }

  Widget buildAppBar() {
    return SizedBox(
      height: 60.h,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: getBackIcon(() {
                  backClick();
                }, color: Colors.black),
              )),
              buildPopupMenuButton((value) {
                controller.changeSearchByValue(value);
              }, controller.searchByList, 'arrow_down.svg'),
              getHorSpace(10.w)
            ],
          ),
          Center(
            child: GetBuilder<SearcController>(
                init: SearcController(),
                builder: (controller) {
                  return getCustomFont(
                      "Search for ${controller.searchByValue.value}",
                      24.sp,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center);
                }),
          ),
          Align(alignment: Alignment.bottomCenter, child: getDivider())
        ],
      ),
    );
  }

  ListView buildRecentSearchTab() {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ModelRecentSearch recentSearch = recentSearchList[index];
        return SizedBox(
            height: 41.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage('recent.svg', height: 24.h, width: 24.h),
                getHorSpace(6.h),
                Expanded(
                    child: getCustomFont(
                            recentSearch.title, 17.sp, Colors.black, 1,
                            fontWeight: FontWeight.w500)
                        .paddingSymmetric(vertical: 12.h)),
                getSvgImage('close.svg', height: 16.h, width: 16.h),
              ],
            ).marginSymmetric(horizontal: 20.h));
      },
      separatorBuilder: (BuildContext context, int index) {
        return getDivider(endIndent: 20.h, indent: 20.h);
      },
    );
  }
}
