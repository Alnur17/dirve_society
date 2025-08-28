// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:dirve_society/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:dirve_society/app/modules/profile/controllers/profile_controller.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/common/widgets/custom_textfield.dart';
import 'package:dirve_society/common/widgets/image_picker.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class EditProfileDetailsView extends StatefulWidget {
  const EditProfileDetailsView({super.key});

  @override
  State<EditProfileDetailsView> createState() => _EditProfileDetailsViewState();
}

class _EditProfileDetailsViewState extends State<EditProfileDetailsView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  final ProfileController profileController = Get.put(ProfileController());
  final formKey = GlobalKey<FormState>();
  File? image;
  File? bannerImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @override
  void initState() {
    nameController.text =
        StorageUtil.getData(StorageUtil.profileName) ?? 'No name';
    emailController.text =
        StorageUtil.getData(StorageUtil.profileEmail) ?? 'No email';
    bioController.text = StorageUtil.getData(StorageUtil.profileBio) ?? '';
    addressController.text =
        StorageUtil.getData(StorageUtil.profileAddress) ?? '';
    print('Name: ${StorageUtil.getData(StorageUtil.profileName)}');
    print('Email: ${StorageUtil.getData(StorageUtil.profileEmail)}');
    print('Bio: ${StorageUtil.getData(StorageUtil.profileBio)}');
    print('Address: ${StorageUtil.getData(StorageUtil.profileAddress)}');
    print('Image: ${StorageUtil.getData(StorageUtil.profilePhotoUrl)}');
    print('Banner: ${StorageUtil.getData(StorageUtil.profileCoverPhoto)}');
    super.initState();
  }

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
                  child: bannerImage == null
                      ? Image.network(
                          StorageUtil.getData(StorageUtil.profileCoverPhoto)!,
                          fit: BoxFit.cover,
                        )
                      : Image.file(bannerImage!, fit: BoxFit.cover),
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
                  backgroundImage: image == null
                      ? NetworkImage(
                          StorageUtil.getData(StorageUtil.profilePhotoUrl)!)
                      : FileImage(image!),
                ),
              ),
              Positioned(
                bottom: -10,
                left: 90,
                child: InkWell(
                  onTap: () {
                    _imagePickerHelper.showAlertDialog(context, (
                      File pickedImage,
                    ) {
                      setState(() {
                        image = pickedImage;
                      });
                    });
                  },
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
              ),
              Positioned(
                top: 40,
                right: 20,
                child: InkWell(
                  onTap: () {
                    _imagePickerHelper.showAlertDialog(context, (
                      File pickedImage,
                    ) {
                      setState(() {
                        bannerImage = pickedImage;
                      });
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 247, 247, 247),
                    ),
                    child: Image.asset(
                      AppImages.camera,
                      scale: 3.5,
                    ),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: h5,
                      ),
                      sh5,
                      CustomTextField(
                        onChange: (String value) {},
                        textColor: Colors.black,
                        controller: nameController,
                        hintTextStyle: TextStyle(color: AppColors.black),
                      ),
                      sh20,
                      Text(
                        'Email',
                        style: h5,
                      ),
                      sh5,
                      CustomTextField(
                        onChange: (String value) {},
                        textColor: Colors.black,
                        controller: emailController,
                        hintTextStyle: TextStyle(color: AppColors.black),
                      ),
                      sh20,
                      Text(
                        'Bio',
                        style: h5,
                      ),
                      sh5,
                      CustomTextField(
                        onChange: (String value) {},
                        textColor: Colors.black,
                        controller: bioController,
                        hintTextStyle: TextStyle(color: AppColors.black),
                      ),
                      sh20,
                      Text(
                        'Address',
                        style: h5,
                      ),
                      sh5,
                      CustomTextField(
                        onChange: (String value) {},
                        textColor: Colors.black,
                        controller: addressController,
                        hintTextStyle: TextStyle(color: AppColors.black),
                      ),
                      sh20,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Obx(
              // NEW CHANGE: Added Obx to observe inProgress
              () => CustomButton(
                text: 'Save',
                isLoading: editProfileController
                    .inProgress, // NEW CHANGE: Added isLoading prop
                onPressedAsync: () async {
                  await editProfile();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> editProfile() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await editProfileController.updateProfile(
        nameController.text,
        bioController.text,
        addressController.text,
        image,
        cover: bannerImage,
      );

      if (isSuccess) {
        if (mounted) {
          await profileController.fetchProfileData();
          // showSnackBarMessage(context, 'Profile updated successfully');
          Get.back();
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context,
              editProfileController.errorMessage ?? 'Failed to update profile',
              true);
        }
      }
    }
  }
}
