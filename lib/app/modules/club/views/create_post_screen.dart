import 'dart:io';

import 'package:dirve_society/app/modules/club/controllers/all_club_field_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/create_club_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/create_post_controller.dart';
import 'package:dirve_society/app/modules/club/views/club_view.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_club_controller.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_feed_controller.dart';
import 'package:dirve_society/app/modules/profile/views/my_post_view.dart';
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

// ignore: must_be_immutable
class CreatePostView extends StatefulWidget {
  String? clubId;
  String? authorId;
  CreatePostView({super.key, this.clubId, this.authorId});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final MyFeedController myFeedController = Get.put(MyFeedController());
  String privacy = 'public'; // Changed from final to non-final
  final CreateClubController createClubController =
      Get.put(CreateClubController());
  final MyClubController myClubController = Get.put(MyClubController());
  final CreatePostController createPostController =
      Get.put(CreatePostController());
  final AllClubFeedController allClubFeedController =
      Get.put(AllClubFeedController());

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
          'Create Post',
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
                  'Tags',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                  onChange: (String value) {},
                  controller: nameController,
                  hintText: 'Enter tag',
                ),
                sh16,
                Text(
                  'Description',
                  style: h5,
                ),
                sh8,
                CustomTextField(
                  onChange: (String value) {},
                  controller: descriptionController,
                  hintText: 'Describe about your club',
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
          // NEW CHANGE: Added Obx to observe inProgress
          () => CustomButton(
            text: 'Create',
            isLoading: createPostController
                .inProgress, // NEW CHANGE: Added isLoading prop
            onPressedAsync: () async {
              await createPost();
            },
          ),
        ),
      ),
    );
  }

  Future<void> createPost() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await createPostController.createPost(
        nameController.text,
        privacy,
        descriptionController.text,
        profileImage,
        clubId: widget.clubId,
      );

      if (isSuccess) {
        if (mounted) {
          if (widget.clubId != null) {
            await allClubFeedController.getAllClubFeed(widget.clubId!);
            await Get.to(() => ClubView(
                  isAuthor: true,
                  id: widget.clubId ?? '',
                  authorId: widget.authorId ?? '',
                ));
          } else {
            await myClubController.getMyClub();
            await Get.to(() => MyPostView());
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            createPostController.errorMessage ??
                'Failed to create post', // NEW CHANGE: Updated to use createPostController.errorMessage
            true,
          );
        }
      }
    }
  }
}
