import 'package:dirve_society/app/modules/club/controllers/club_details_controller.dart';
import 'package:dirve_society/app/modules/club/views/feed_screen.dart';
import 'package:dirve_society/app/modules/club/views/forum_screen.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_text_style/styles.dart';

class ClubView extends StatefulWidget {
  final String id;
  const ClubView({super.key, required this.id});

  @override
  State<ClubView> createState() => _ClubViewState();
}

class _ClubViewState extends State<ClubView> {
  final ClubDetailsController clubDetailsController =
      Get.put(ClubDetailsController());
  int selectedIndex = 0;

  @override
  void initState() {
    clubDetailsController.getClubDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder<ClubDetailsController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(controller.clubDetails!.coverPhoto ??
                      'https://fastly.picsum.photos/id/685/200/200.jpg?hmac=1IjDFMSIa0T_JSvcq79_e2NWPwRJg61Ufbfu4eM4HvA'),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
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
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              color: AppColors.black.withOpacity(0.3),
                            ),
                            child: Image.asset(
                              AppImages.menu,
                              scale: 4,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.13),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.white,
                          backgroundImage: NetworkImage(controller
                                  .clubDetails!.profilePhoto ??
                              'https://fastly.picsum.photos/id/685/200/200.jpg?hmac=1IjDFMSIa0T_JSvcq79_e2NWPwRJg61Ufbfu4eM4HvA'),
                        ),
                        sw12,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              controller.clubDetails!.name ?? '',
                              style: h1.copyWith(
                                  fontSize: 20, color: AppColors.darkRed),
                            ),
                            sh5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppImages.groupLight,
                                  scale: 4,
                                ),
                                sw5,
                                Text(
                                  '${controller.clubDetails!.member.toString()} Members',
                                  style: h6,
                                ),
                              ],
                            ),
                            sh5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppImages.public,
                                  scale: 4,
                                ),
                                sw5,
                                Text(controller.clubDetails!.type ?? '',
                                    style: h6),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          AppImages.invite,
                          scale: 4,
                        ),
                        sw8,
                        Text(
                          'Invite',
                          style: h5.copyWith(
                            color: AppColors.darkRed,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  sh20,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(6),
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
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: selectedIndex == 0
                                        ? AppColors.darkRed
                                        : AppColors.transparent),
                                child: Center(
                                  child: Text(
                                    'FEED',
                                    style: TextStyle(
                                        fontWeight: selectedIndex == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selectedIndex == 0
                                            ? AppColors.white
                                            : AppColors.black),
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
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: selectedIndex == 1
                                        ? AppColors.darkRed
                                        : AppColors.transparent),
                                child: Center(
                                  child: Text(
                                    'FORUM',
                                    style: TextStyle(
                                        fontWeight: selectedIndex == 1
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selectedIndex == 1
                                            ? AppColors.white
                                            : AppColors.black),
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
                        ? FeedScreen(
                            clubId: widget.id,
                          )
                        : ForumScreen(
                            clubId: widget.id,
                          ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.darkRed,
          child: Icon(
            Icons.add,
            size: 32,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
