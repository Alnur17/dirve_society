import 'dart:io';

import 'package:dirve_society/app/modules/club/controllers/create_club_controller.dart';
import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
import 'package:dirve_society/app/modules/home/controllers/feed/create_story_controller.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_club_controller.dart';
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

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final CreateClubController createClubController =
      Get.put(CreateClubController());
  final MyClubController myClubController = Get.put(MyClubController());
  final AddStoryController addStoryController = Get.put(AddStoryController());

  final formKey = GlobalKey<FormState>();
  File? profileImage;
  File? coverImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Add Story',
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
                Text(
                  'Caption',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                  onChange: (String value) {},
                  controller: captionController,
                  hintText: 'Write here',
                ),
                sh16,
                Text(
                  'Profile Photo',
                  style: h5,
                ),
                sh8,
                UploadWidget(
                  onTap: () {
                    _imagePickerHelper.showAlertDialog(context,
                        (File pickedImage) {
                      setState(() {
                        profileImage = pickedImage;
                      });
                    });
                  },
                  imagePath: AppImages.upload,
                  imageFile: profileImage,
                  label: 'Upload',
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
          child: Obx(
            () => CustomButton(
              isLoading: addStoryController.inProgress,
              text: 'Add Story',
              onPressedAsync: () async {
                await addStory();
              },
            ),
          )),
    );
  }

  Future<void> addStory() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await addStoryController.addStory(
          captionController.text, profileImage);

      if (isSuccess) {
        Get.to(() => DashboardView());
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            addStoryController.errorMessage ?? 'Failed to create club',
            true,
          );
        }
      }
    }
  }
}
