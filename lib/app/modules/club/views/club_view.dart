import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/helper/forum_card.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/post_card.dart';
import '../controllers/club_controller.dart';

class ClubView extends GetView<ClubController> {
  const ClubView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClubController());
    final screenHeight = Get.height;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.coverImage),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        backgroundImage: AssetImage(AppImages.carImageFive),
                      ),
                      sw12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Super Car',
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
                                '10.1K Members',
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
                              Text('Public Club', style: h6),
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
                  child: Obx(
                    () => Container(
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
                                controller.isFeedSelected.value = true;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: controller.isFeedSelected.value
                                      ? AppColors.darkRed
                                      : AppColors.transparent,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'FEED',
                                    style: TextStyle(
                                      color: controller.isFeedSelected.value
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
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
                                controller.isFeedSelected.value = false;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: controller.isFeedSelected.value
                                      ? AppColors.transparent
                                      : AppColors.darkRed,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Forum',
                                    style: TextStyle(
                                      color: controller.isFeedSelected.value
                                          ? AppColors.black
                                          : AppColors.white,
                                      fontWeight: FontWeight.bold,
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
                ),
                Expanded(
                  child: Obx(
                    () => controller.isFeedSelected.value
                        ? ListView.builder(
                            padding: EdgeInsets.only(bottom: 30),
                            itemCount: 10,
                            itemBuilder: (context, index) => PostCard(
                              clubName: 'MC20 Owners CLUB',
                              userName: 'John Doe',
                              postImages: [
                                AppImages.carImage,
                                AppImages.carImageThree,
                                AppImages.carImageTwo,
                              ],
                              description:
                                  'Nam posuere elit a facilisis hendrerit. Phasellus cursus nisi vel tempor gravida. Vivamus sollicitudin a nisi eu aliquam aliqu...',
                              hashtags: '#Blessed #MC20',
                              date: 'April 4',
                              likes: 100,
                              comments: 100,
                              onProfileTap: () {},
                              onMenuTap: () {},
                              onLikeTap: () {},
                              onCommentTap: () {},
                              onBookmarkTap: () {},
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 30),
                            itemCount: 10,
                            itemBuilder: (context, index) => ForumCard(
                              imagePath: AppImages.carImage,
                              clubName: 'MC20 Owners Club',
                              author: 'John Doe',
                              date: 'April 2025',
                              title: 'Turbo Issue',
                              description:
                                  'Nam posuere elit a facilisis hendrerit. Phasellus cursus nisi vel tempor gravida. Vivamus sollicitudin a nisi eu aliquam.',
                              likeImage: AppImages.like,
                              dislikesImage: AppImages.unLike,
                              commentsImage: AppImages.chat,
                              comments: 2,
                              likes: 25,
                              dislikes: 12,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.darkRed,
          child: Icon(Icons.add,size: 32,color: AppColors.white,),
        ),
      ),
    );
  }
}
