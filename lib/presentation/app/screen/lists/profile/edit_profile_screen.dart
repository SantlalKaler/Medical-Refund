import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lab_test_app/presentation/app/screen/lists/profile/profile_controller.dart';

import '../../../../../data/app_urls.dart';
import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  void backClick() {
    Constant.backToPrev(context: context);
  }

  late final ProfileController profileController;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.delete<ProfileController>();
    profileController = Get.put(ProfileController());
    profileController.getUser();
    profileController.getCities();
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
              children: [
                getVerSpace(20.h),
                getBackAppBar(context, () {
                  backClick();
                }, 'Edit Profile'),
                getVerSpace(20.h),
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  builder: (controller) => controller.user.value == null &&
                          controller.specialist.value == null
                      ? getEmptyView()
                      : Expanded(
                          child: ListView(
                            children: [
                              Row(
                                children: [
                                  getProfileCell(context),
                                  Expanded(child: getHorSpace(0.h)),
                                ],
                              ),
                              getVerSpace(30.h),
                              buildTextFieldWidget(context),
                            ],
                          ),
                        ),
                ),
                buildSaveButton(context),
                getVerSpace(30.h),
              ],
            ),
          ),
        ));
  }

  Widget buildSaveButton(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => controller.loading.value
          ? showLoading()
          : getButton(
              context,
              accentColor,
              'Save',
              Colors.white,
              () {
                controller.validate();
              },
              18.sp,
              borderRadius: BorderRadius.all(Radius.circular(22.h)),
              buttonHeight: 60.h,
            ).marginSymmetric(horizontal: 20.h),
    );
  }

  Widget buildTextFieldWidget(BuildContext context) {
    bool isSpecialist = profileController.isSpecialist.value;
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formGlobalKey,
      child: Column(
        children: [
          getDefaultTextFiledWithLabel(
            context,
            "Enter full name",
            profileController.nameController.value,
            height: 60.h,
            validator: (email) {
              if (email!.isNotEmpty) {
                return null;
              } else {
                return 'Please enter full name';
              }
            },
          ),
          getVerSpace(20.h),
          getDefaultTextFiledWithLabel(
            context,
            "Enter your email",
            profileController.emailController.value,
            height: 60.h,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email!.isNotEmpty) {
                return null;
              } else {
                return 'Please enter email address';
              }
            },
          ),
          getVerSpace(20.h),
          !isSpecialist
              ? Column(
                  children: [
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter phone number",
                      profileController.phoneController.value,
                      isEnable: false,
                      height: 60.h,
                      keyboardType: TextInputType.phone,
                      validator: (email) {
                        if (email!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter phone number';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(context, "Date of Birth",
                        profileController.birthController.value,
                        height: 60.h,
                        withSufix: true,
                        suffiximage: 'calender.svg',
                        keyboardType: TextInputType.none, onTap: () {
                      getCalenderBottomSheet(context, 'Select Date', 'fire',
                          (dob) {
                        print("dob is : $dob");
                        profileController.changeDob(dob);
                      });
                    }),
                  ],
                )
              : const SizedBox(),
          isSpecialist
              ? Column(
                  children: [
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter your price before",
                      profileController.priceBeforeController.value,
                      height: 60.h,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter price before';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter your price.",
                      profileController.priceController.value,
                      height: 60.h,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter price';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getGreyRoundedContainer(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomFont(profileController.city.value!.name!, 14,
                            Colors.black, 1),
                        buildPopupMenuButton((value) {
                          profileController.updateCity(value);
                        },
                            profileController.cities.value!.result!
                                .map((e) => e.name!)
                                .toList(),
                            'arrow_down.svg')
                      ],
                    )),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter your office address",
                      profileController.addressController.value,
                      height: 60.h,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter your office address';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter total patients",
                      profileController.totalPatientsController.value,
                      height: 60.h,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter total patients';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter your experience",
                      profileController.experienceController.value,
                      height: 60.h,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter total experience you have.';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getDefaultTextFiledWithLabel(
                      context,
                      "Enter education",
                      profileController.educationController.value,
                      height: 60.h,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return 'Please enter your education.';
                        }
                      },
                    ),
                    getVerSpace(20.h),
                    getGreyRoundedContainer(
                      padding: EdgeInsets.all(0.h),
                      child: getDefaultTextFiledWithLabel(
                        context,
                        minLines: true,
                        "Enter description",
                        profileController.descController.value,
                        height: 200.h,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter description.';
                          }
                        },
                      ),
                    ),
                    getVerSpace(20.h),
                  ],
                )
              : const SizedBox()
        ],
      ).marginSymmetric(horizontal: 20.h),
    );
  }

  getProfileCell(BuildContext context) {
    return SizedBox(
      width: 100.h,
      height: 97.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: profileController.picName.isEmpty
                  ? getCircularNetworkImage(context, 92.h, 92.h, 22.h,
                      "${AppUrls.imageBaseUrl}${profileController.isSpecialist.value ? profileController.specialist.value?.image : profileController.user.value!.image!}",
                      boxFit: BoxFit.fill)
                  : getCircularFileImage(context, 92.h, 92.h, 22.h,
                      profileController.picPath.value,
                      boxFit: BoxFit.fill),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  _profilePic();
                },
                child: Container(
                  width: 36.h,
                  height: 36.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x289a90b8),
                        blurRadius: 32.h,
                        offset: const Offset(0, 9),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Center(
                    child: getSvgImage('edit.svg', height: 24.h, width: 24.h),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).marginSymmetric(horizontal: 20.h);
  }

  _profilePic() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);

    if (result == null) return;
    profileController.setPicNameNPath(
        result.files.first.name, result.files.first.path!);
    print(
        "Profile name : ${result.files.first.name}\n file path : ${result.files.first.path}");
  }
}
