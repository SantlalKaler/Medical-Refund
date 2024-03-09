import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/review.dart';
import 'package:lab_test_app/presentation/app/screen/lists/review/review_controller.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReviewsScreenState();
  }
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late ReviewController controller;

  @override
  void initState() {
    Get.delete<ReviewController>();
    controller = Get.put(ReviewController());
    controller.getUser();
    var args = Get.arguments;
    if (args.containsKey('lab')) {
      controller.reviewOf = args;
    } else {
      controller.reviewOf = args;
    }
    controller.getDetails();
    super.initState();
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
          child: Column(
            children: [
              getVerSpace(20.h),
              getBackAppBar(context, () {
                backClick();
              }, 'Reviews'),
              getVerSpace(20.h),
              Expanded(
                  child: GetBuilder<ReviewController>(
                init: ReviewController(),
                builder: (controller) => (controller.loading.value)
                    ? showLoading()
                    : (controller.reviewList.isEmpty)
                        ? buildNoReviewView(context)
                        : buildReviewList(),
              )),
              buildHomeVisitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHomeVisitButton() {
    return getButton(
      context,
      accentColor,
      "Write a Review",
      Colors.white,
      () {
        showDialog(
            builder: (context) {
              return addReviewDialog();
            },
            context: context);
      },
      18.sp,
      weight: FontWeight.w700,
      buttonHeight: 60.h,
      borderRadius: BorderRadius.circular(22.h),
      borderWidth: 2.h,
    ).marginSymmetric(horizontal: 20.h, vertical: 30.h);
  }

  Widget addReviewDialog() {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.h),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.h)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.h),
        width: 374.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(31.h),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                  onTap: () => Constant.backToPrev(),
                  child: getSvgImage('close_circle.svg')),
            ),
            getVerSpace(31.h),
            loginHeader("Add Review", "Give feedback to our service"),
            getVerSpace(40.h),
            RatingBar.builder(
              initialRating: controller.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.rating = rating;
                Constant.printValue(rating);
              },
            ),
            getVerSpace(40.h),
            getGreyRoundedContainer(
              padding: EdgeInsets.all(0.h),
              child: getDefaultTextFiledWithLabel(
                context,
                "Enter your review",
                controller.reviewMessage.value,
                height: 100.h,
                minLines: true,
                keyboardType: TextInputType.multiline,
                action: TextInputAction.newline,
              ),
            ),
            getVerSpace(31.h),
            getButton(context, accentColor, "Ok", Colors.white, () {
              if (controller.reviewMessage.value.text.isEmpty) {
                showSnackbar("Message", 'Please enter message');
              } else {
                controller.getBookings();
                Constant.backToPrev();
              }
            }, 18.sp,
                weight: FontWeight.w700,
                buttonHeight: 60.h,
                borderRadius: BorderRadius.circular(22.h)),
            getVerSpace(30.h)
          ],
        ),
      ),
    );
  }

  Widget buildReviewList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.reviewList.length,
      itemBuilder: (context, index) {
        Reviews review = controller.reviewList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(20.h),
            Row(
              children: [
                getCircleNetworkImage(
                    context,
                    review.user?.image == null
                        ? Constant.profilePic
                        : "${AppUrls.imageBaseUrl}${review.user!.image!}",
                    44.h),
                getHorSpace(10.h),
                Expanded(
                    child: getCustomFont(
                        review.user?.name ?? '', 16.sp, Colors.black, 1,
                        fontWeight: FontWeight.w700)),
                getCustomFont(Constant.changeDateFormat(review.createdAt!),
                    15.sp, greyFontColor, 1,
                    fontWeight: FontWeight.w500),
              ],
            ),
            getVerSpace(6.h),
            getMultilineCustomFont(review.message!, 17.sp, Colors.black,
                    fontWeight: FontWeight.w500, txtHeight: 1.7.h)
                .marginOnly(left: 54.h),
            /*getVerSpace(10.h),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      getSvgImage('comment.svg', height: 20.h, width: 20.h),
                      getHorSpace(14.h),
                      getSvgImage('heart.svg', height: 20.h, width: 20.h),
                    ],
                  ),
                ),
                getSvgImage('share.svg', height: 20.h, width: 20.h),
              ],
            ).marginOnly(left: 54.h),*/
            getVerSpace(20.h),
            getDivider(),
          ],
        );
      },
    ).marginSymmetric(horizontal: 20.h);
  }

  Column buildNoReviewView(BuildContext context) {
    return Column(
      children: [
        getVerSpace(161.h),
        getNoDataWidget(context, 'No Reviews Yet!',
            'Come on, maybe we still have a \nchance', "no_rating_icon.svg"),
      ],
    );
  }
}
