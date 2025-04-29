import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/upload_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';

class AddCarView extends GetView {
  const AddCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Add Car',
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
                'Brand',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'Enter your car brand name',
              ),
              sh16,
              Text(
                'Model',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'Enter your car model name',
              ),
              sh16,
              Text(
                'Mileage (Miles)',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '4',
              ),
              sh16,
              Text(
                'Transmission',
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
                value: 'Gasoline ',
                items: ['Gasoline ', 'Diesel']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {},
              ),
              sh16,
              Text(
                'Transmission',
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
                value: 'Manual',
                items: ['Manual', 'Automatic']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {},
              ),
              sh16,
              Text(
                'Selling Price',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '\$4000',
              ),
              sh16,
              Text(
                'Car Description',
                style: h5,
              ),
              sh8,
              CustomTextField(
                height: 120,
                hintText: 'Describe your car so people know what it\'s about.',
              ),
              sh16,
              Text(
                'Car Photo',
                style: h5,
              ),
              sh8,
              UploadWidget(
                onTap: () {},
                imagePath: AppImages.upload,
                label: 'Upload',
                iconSize: 48,
              ),
              sh8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UploadWidget(
                      height: 100,
                      width: 100,
                      onTap: () {},
                      imagePath: AppImages.add,
                      label: 'Front'),
                  UploadWidget(
                      height: 100,
                      width: 100,
                      onTap: () {},
                      imagePath: AppImages.add,
                      label: 'Side'),
                  UploadWidget(
                      height: 100,
                      width: 100,
                      onTap: () {},
                      imagePath: AppImages.add,
                      label: 'Sole'),
                ],
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
