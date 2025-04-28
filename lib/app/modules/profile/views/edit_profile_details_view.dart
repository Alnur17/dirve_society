import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:dirve_society/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class EditProfileDetailsView extends GetView {
  const EditProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.mainColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColors.black.withOpacity(0.3),
                      ),
                      child: Image.asset(
                        AppImages.back,
                        scale: 4,
                      )),
                ),
              ),
              Positioned(
                bottom: -25,
                left: 20,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                bottom: -10,
                left: 90,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.darkRed,
                  ),
                  child: Image.asset(
                    AppImages.camera,
                    scale: 4,
                  ),
                ),
              ),
            ],
          ),
          sh40,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: h5,
                    ),
                    sh5,
                    CustomTextField(
                      hintText: 'Enter your car name',
                    ),
                    sh20,
                    Text(
                      'Email',
                      style: h5,
                    ),
                    sh5,
                    CustomTextField(
                      hintText: 'gtr@gmail.com',
                    ),
                    sh20,
                    Text(
                      'Bio',
                      style: h5,
                    ),
                    sh5,
                    CustomTextField(
                      hintText: 'Enter short bio of your car',
                    ),
                    sh20,
                    Text(
                      'Address',
                      style: h5,
                    ),
                    sh5,
                    CustomTextField(
                      hintText: 'Enter your address here',
                    ),
                    sh20,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomButton(text: 'Save', onPressed: () {}),
          )
        ],
      ),
    );
  }
}
