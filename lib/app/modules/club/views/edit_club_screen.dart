import 'dart:io';
import 'package:dirve_society/app/modules/club/controllers/club_details_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/create_club_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/edit_create_controller.dart';
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

class EditClubView extends StatefulWidget {
  final String clubId;
  const EditClubView({super.key, required this.clubId});

  @override
  State<EditClubView> createState() => _EditClubViewState();
}

class _EditClubViewState extends State<EditClubView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ClubDetailsController clubDetailsController =
      Get.put(ClubDetailsController());
  String privacy = 'public';
  final CreateClubController createClubController =
      Get.put(CreateClubController());
  final MyClubController myClubController = Get.put(MyClubController());
  final EditClubController editClubController = Get.put(EditClubController());
  final formKey = GlobalKey<FormState>();
  File? profileImage;
  File? coverImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clubDetailsController.getClubDetails(widget.clubId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Edit Club',
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
      body: GetBuilder<ClubDetailsController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        // Set initial values from club details
        nameController.text = controller.clubDetails?.name ?? '';
        descriptionController.text = controller.clubDetails?.description ?? '';
        privacy = controller.clubDetails?.type ?? 'public';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sh30,
                  Text('Club Name', style: h5),
                  sh8,
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Enter your club name',
                  ),
                  sh16,
                  Text('Privacy', style: h5),
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
                    value: privacy,
                    items: ['public', 'private']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        privacy = newValue!;
                      });
                    },
                  ),
                  sh16,
                  Text('Description', style: h5),
                  sh8,
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Describe about your club',
                  ),
                  sh16,
                  Text('Profile Photo', style: h5),
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
                    networkImage: controller
                        .clubDetails?.profilePhoto, // API-fetched profile image
                    label: 'Upload',
                  ),
                  sh16,
                  Text('Cover Photo', style: h5),
                  sh8,
                  UploadWidget(
                    onTap: () {
                      _imagePickerHelper.showAlertDialog(context,
                          (File pickedImage) {
                        setState(() {
                          coverImage = pickedImage;
                        });
                      });
                    },
                    imagePath: AppImages.upload,
                    imageFile: coverImage,
                    networkImage: controller
                        .clubDetails?.coverPhoto, // API-fetched cover image
                    label: 'Upload',
                  ),
                  sh100,
                ],
              ),
            ),
          ),
        );
      }),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomButton(
          text: 'Update',
          onPressed: () {
            editClub();
          },
        ),
      ),
    );
  }

  Future<void> editClub() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await editClubController.editClub(
        widget.clubId,
        nameController.text,
        privacy,
        descriptionController.text,
        profileImage,
        cover: coverImage,
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Club edited successfully');
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            editClubController.errorMessage ?? 'Failed to create club',
            true,
          );
        }
      }
    }
  }
}
