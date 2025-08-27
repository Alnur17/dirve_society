import 'dart:io';

import 'package:dirve_society/app/modules/profile/controllers/add_car_controller.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/common/widgets/image_picker.dart';
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

class AddCarView extends StatefulWidget {
  const AddCarView({super.key});

  @override
  State<AddCarView> createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddCarView> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController transmissionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AddCarController addCarController = Get.put(AddCarController());

  File? bannerImage;
  List<File?> carImages = [null, null, null]; // For Front, Side, Sole
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

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
          child: Form(
            key: formKey,
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
                   onChange: (String value) {  },
                  hintText: 'Enter your car brand name',
                  controller: brandController,
                ),
                sh16,
                Text(
                  'Model',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  hintText: 'Enter your car model name',
                  controller: modelController,
                ),
                sh16,
                Text(
                  'Mileage (Miles)',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  hintText: 'Enter mileage (e.g., 4)',
                  controller: mileageController,
                ),
                sh16,
                Text(
                  'Fuel Type',
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  value: fuelTypeController.text.isEmpty
                      ? 'Gasoline'
                      : fuelTypeController.text,
                  items: ['Gasoline', 'Diesel']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      fuelTypeController.text = newValue;
                    }
                  },
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  value: transmissionController.text.isEmpty
                      ? 'Manual'
                      : transmissionController.text,
                  items: ['Manual', 'Automatic']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      transmissionController.text = newValue;
                    }
                  },
                ),
                sh16,
                Text(
                  'Selling Price',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  hintText: '\$4000',
                  controller: priceController,
                ),
                sh16,
                Text(
                  'Year',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  hintText: 'year',
                  controller: yearController,
                ),
                sh16,
                Text(
                  'Condition',
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  value: conditionController.text.isEmpty
                      ? 'New'
                      : conditionController.text,
                  items: ['New', 'Used']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      conditionController.text = newValue;
                    }
                  },
                ),
                sh16,
                Text(
                  'Color',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  hintText: 'Color',
                  controller: colorController,
                ),
                sh16,
                Text(
                  'Car Description',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                   onChange: (String value) {  },
                  height: 120,
                  hintText:
                      'Describe your car so people know what it\'s about.',
                  controller: descriptionController,
                ),
                sh16,
                Text(
                  'Car Photo',
                  style: h5,
                ),
                sh8,
                UploadWidget(
                  onTap: () {
                    _imagePickerHelper.showAlertDialog(context,
                        (File pickedImage) {
                      setState(() {
                        bannerImage = pickedImage;
                      });
                    });
                  },
                  imagePath: AppImages.upload,
                  imageFile: bannerImage,
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
                      onTap: () {
                        _imagePickerHelper.showAlertDialog(context,
                            (File pickedImage) {
                          setState(() {
                            carImages[0] = pickedImage;
                          });
                        });
                      },
                      imagePath: AppImages.add,
                      imageFile: carImages[0],
                      label: 'Front',
                      iconSize: 20,
                    ),
                    UploadWidget(
                      height: 100,
                      width: 100,
                      onTap: () {
                        _imagePickerHelper.showAlertDialog(context,
                            (File pickedImage) {
                          setState(() {
                            carImages[1] = pickedImage;
                          });
                        });
                      },
                      imagePath: AppImages.add,
                      imageFile: carImages[1],
                      label: 'Side',
                      iconSize: 20,
                    ),
                    UploadWidget(
                      height: 100,
                      width: 100,
                      onTap: () {
                        _imagePickerHelper.showAlertDialog(context,
                            (File pickedImage) {
                          setState(() {
                            carImages[2] = pickedImage;
                          });
                        });
                      },
                      imagePath: AppImages.add,
                      imageFile: carImages[2],
                      label: 'Sole',
                      iconSize: 20,
                    ),
                  ],
                ),
                sh100,
              ],
            ),
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
        child: CustomButton(
          text: 'Create',
          onPressed: () {
            createCar();
          },
        ),
      ),
    );
  }

  Future<void> createCar() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await addCarController.addCar(
        brandController.text,
        modelController.text,
        int.parse(mileageController.text),
        fuelTypeController.text,
        transmissionController.text,
        descriptionController.text,
        int.parse(priceController.text),
        conditionController.text,
        colorController.text,
        yearController.text,
        carImages, // Pass the list of images (Front, Side, Sole)
        cover: bannerImage, // Pass the main banner image
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Car added successfully');
          Get.back();
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            addCarController.errorMessage ?? 'Failed to add car',
            true,
          );
        }
      }
    }
  }
}
