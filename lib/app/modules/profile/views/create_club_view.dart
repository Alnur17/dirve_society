import 'package:dirve_society/common/helper/upload_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';

class CreateClubView extends GetView {
  const CreateClubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Create Club',
          style: appBarStyle,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh30,
              Text(
                'Club Name',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'Enter your club name',

              ),
              sh16,
              Text(
                'Privacy',
                style: h5,
              ),
              sh8,
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                value: 'Public Club',
                items: ['Public Club', 'Private Club']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {},
              ),
              sh16,
              Text(
                'Description',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'Describe about your club',
              ),
              sh16,
              Text(
                'Profile Photo',
                style: h5,
              ),
              sh8,
              UploadWidget(
                onTap: () {},
                imagePath: AppImages.upload,
                label: 'Upload',
                iconSize: 48,
              ),
              sh16,
              Text(
                'Cover Photo',
                style: h5,
              ),
              sh8,
              UploadWidget(
                onTap: () {},
                imagePath: AppImages.upload,
                label: 'Upload',
                iconSize: 48,
              ),
              sh100,
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: CustomButton(text: 'Create', onPressed: () {}),
      ),
    );
  }
}
