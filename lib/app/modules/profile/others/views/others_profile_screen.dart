import 'package:dirve_society/app/modules/club/controllers/leave_club_controller.dart';
import 'package:dirve_society/app/modules/profile/others/controller/others_profile_controller.dart';
import 'package:dirve_society/app/modules/profile/others/views/others_profile_feed.dart';
import 'package:dirve_society/app/modules/profile/others/views/others_profile_market_place.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OthersProfileView extends StatefulWidget {
  final String authorId;
  const OthersProfileView({
    super.key,
    required this.authorId,
  });

  @override
  State<OthersProfileView> createState() => _OthersProfileViewState();
}

class _OthersProfileViewState extends State<OthersProfileView> {
  final LeaveClubController leaveClubController =
      Get.put(LeaveClubController());
  int selectedIndex = 0;

  final OthersProfileController othersProfileController =
      Get.put(OthersProfileController());

  @override
  void initState() {
    super.initState();
    othersProfileController.fetchOthersProfileData(widget.authorId);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GestureDetector(
        // Detect taps outside the menu to close it (if needed)
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<OthersProfileController>(builder: (controller) {
          if (controller.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.errorMessage != null &&
              controller.errorMessage!.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage!,
                    style: TextStyle(color: AppColors.darkRed, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.fetchOthersProfileData(widget.authorId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (controller.profileData == null) {
            return const Center(
              child: Text(
                'No profile data available',
                style: TextStyle(color: AppColors.darkRed, fontSize: 16),
              ),
            );
          } else {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: controller.profileData?.coverPhoto == null
                          ? AssetImage(AppImages.noBanner)
                          : NetworkImage(
                              controller.profileData?.coverPhoto ??
                                  'https://fastly.picsum.photos/id/685/200/200.jpg?hmac=1IjDFMSIa0T_JSvcq79_e2NWPwRJg61Ufbfu4eM4HvA',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: AppColors.white.withOpacity(0.15),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  color: AppColors.black.withOpacity(0.3),
                                ),
                                child: Image.asset(
                                  AppImages.back,
                                  scale: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.13),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.white,
                              backgroundImage:
                                  controller.profileData?.photoUrl == null
                                      ? AssetImage(AppImages.noImage)
                                      : NetworkImage(
                                          controller.profileData?.photoUrl ??
                                              'https://fastly.picsum.photos/id/685/200/200.jpg?hmac=1IjDFMSIa0T_JSvcq79_e2NWPwRJg61Ufbfu4eM4HvA',
                                        ),
                            ),
                            sw12,
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                width: 140,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.profileData?.name ?? 'No name',
                                      style: h1.copyWith(
                                        fontSize: 20,
                                        color: AppColors.darkRed,
                                      ),
                                    ),
                                    sh50,
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      sh20,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.silver,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: selectedIndex == 0
                                          ? AppColors.darkRed
                                          : AppColors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'FEED',
                                        style: TextStyle(
                                          fontWeight: selectedIndex == 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: selectedIndex == 0
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              sw8,
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: selectedIndex == 1
                                          ? AppColors.darkRed
                                          : AppColors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'GARAGE',
                                        style: TextStyle(
                                          fontWeight: selectedIndex == 1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: selectedIndex == 1
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: selectedIndex == 0
                            ? OthersFeedScreen(authorId: widget.authorId)
                            : OthersProfileMarketPlace(id: widget.authorId),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
