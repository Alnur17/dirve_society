import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class PostCard extends StatelessWidget {
  final String clubName;
  final String userName;
  final List<String> postImages;
  final String description;
  final String hashtags;
  final String date;
  final int likes;
  final int comments;
  final VoidCallback onProfileTap;
  final VoidCallback onMenuTap;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onBookmarkTap;

  const PostCard({
    super.key,
    required this.clubName,
    required this.userName,
    required this.postImages,
    required this.description,
    required this.hashtags,
    required this.date,
    required this.likes,
    required this.comments,
    required this.onMenuTap,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onBookmarkTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return GestureDetector(
      onTap: onProfileTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(AppImages.carImage),
                  ),
                  sw8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clubName,
                        style: h5.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'BY $userName'.toUpperCase(),
                        style: h7,
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onMenuTap,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColors.silver,
                      ),
                      child: Image.asset(
                        AppImages.menu,
                        scale: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 300.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: postImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(postImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white.withOpacity(0.3),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: postImages.length,
                    effect: WormEffect(
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      activeDotColor: AppColors.white,
                      dotColor: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
            // Post Actions
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onLikeTap,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.silver),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.wheelIcon,
                            scale: 4,
                          ),
                          sw5,
                          Text(
                            likes.toString(),
                            style: h6.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sw16,
                  GestureDetector(
                    onTap: onCommentTap,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.silver),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.chat,
                            scale: 4,
                          ),
                          sw5,
                          Text(
                            comments.toString(),
                            style: h6.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: onBookmarkTap,
                    child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.silver,
                        ),
                        child: Image.asset(
                          AppImages.favorite,
                          scale: 4,
                        )),
                  ),
                ],
              ),
            ),
            sh5,
            // Post Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: h6.copyWith(fontWeight: FontWeight.w600),
                      ),
                      sw8,
                      Expanded(
                        child: Text(
                          hashtags,
                          style: h6.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.red,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  sh5,
                  ReadMoreText(
                    description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: ' Show Less',
                    style: h6,
                    moreStyle: h6.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    lessStyle: h6.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 4,
              ),
              child: Text(
                date,
                style: h6,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
