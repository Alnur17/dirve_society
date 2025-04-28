import 'package:dirve_society/app/modules/profile/views/changed_password_view.dart';
import 'package:dirve_society/app/modules/profile/views/edit_profile_details_view.dart';
import 'package:dirve_society/app/modules/profile/views/my_clubs_view.dart';
import 'package:dirve_society/app/modules/profile/views/my_garage_view.dart';
import 'package:dirve_society/app/modules/profile/views/my_post_view.dart';
import 'package:dirve_society/app/modules/profile/views/privacy_and_security_view.dart';
import 'package:dirve_society/app/modules/profile/views/saved_view.dart';
import 'package:dirve_society/app/modules/profile/views/terms_and_conditions_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../controllers/profile_controller.dart';
import 'about_us_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
              // Positioned(
              //   right: 20,
              //   top: 40,
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: ShapeDecoration(
              //         shape: CircleBorder(),
              //         color: AppColors.black.withOpacity(0.3),
              //       ),
              //       child: Image.asset(
              //         AppImages.menu,
              //         scale: 4,
              //         color: AppColors.white,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: -50,
                left: 20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                right: 20,
                left: Get.width * 0.365,
                bottom: -80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nissan R35 GTR',
                      style: h1.copyWith(
                        fontSize: 20,
                        color: AppColors.darkRed,
                      ),
                    ),
                    sh5,
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: AppColors.darkRed,
                        ),
                        sw5,
                        Text(
                          '4.7',
                          style: h6,
                        ),

                      ],
                    ),
                    sh5,
                    Text(
                      '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                      style: h6,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                    // ReadMoreText(
                    //   '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                    //   trimLines: 2,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: 'Show More',
                    //   trimExpandedText: ' Show Less',
                    //   style: h6,
                    //   moreStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   lessStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: -60,
                right: Get.width * 0.67,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange[600],
                  ),
                  child: Center(
                    child: Text(
                      '190 Points',
                      style: h6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          sh100, // Kept for spacing after profile section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomListTile(
                      onTap: () {
                        Get.to(() => EditProfileDetailsView());
                      },
                      leadingImage: AppImages.edit,
                      title: 'Edit Profile Details',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => MyPostView());
                      },
                      leadingImage: AppImages.gallery,
                      title: 'My Posts',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => MyGarageView());
                      },
                      leadingImage: AppImages.garage,
                      title: 'My Garage',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => MyClubsView());
                      },
                      leadingImage: AppImages.edit,
                      title: 'My Clubs',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => SavedView());
                      },
                      leadingImage: AppImages.favorite,
                      title: 'Saved',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => ChangedPasswordView());
                      },
                      leadingImage: AppImages.keyLight,
                      title: 'Change Password',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => PrivacyAndSecurityView());
                      },
                      leadingImage: AppImages.privacy,
                      title: 'Privacy and security',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => TermsAndConditionsView());
                      },
                      leadingImage: AppImages.termsAndConditions,
                      title: 'Terms & Conditions',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    CustomListTile(
                      onTap: () {
                        Get.to(() => AboutUsView());
                      },
                      leadingImage: AppImages.aboutUs,
                      title: 'About Us',
                      trailingImage: AppImages.arrowRightSmall,
                    ),
                    sh12,
                    Center(
                      child: CustomButton(
                        text: 'Log Out',
                        onPressed: () {},
                        imageAssetPath: AppImages.logout,
                        width: 150,
                        textColor: AppColors.red,
                        backgroundColor: Colors.red[50],
                      ),
                    ),
                    sh40,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
