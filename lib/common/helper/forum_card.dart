import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../app_color/app_colors.dart';
import '../size_box/custom_sizebox.dart';

class ForumCard extends StatelessWidget {
  final String imagePath;
  final String clubName;
  final String author;
  final String date;
  final String title;
  final String description;
  final String likeImage;
  final int likes;
  final int dislikes;
  final String dislikesImage;
  final int comments;
  final String commentsImage;
  final VoidCallback? onTap;

  const ForumCard({
    super.key,
    required this.imagePath,
    required this.clubName,
    required this.author,
    required this.date,
    required this.title,
    required this.description,
    this.likes = 0,
    this.dislikes = 0,
    this.comments = 0,
    this.onTap,
    required this.likeImage,
    required this.dislikesImage,
    required this.commentsImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Club name, author, and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(imagePath),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clubName,
                          style: h6.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'by $author',
                          style: h6.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  date,
                  style: h6,
                ),
              ],
            ),
            Divider(),
            Text(
              title,
              style: h3.copyWith(fontSize: 18),
            ),
            sh8,
            ReadMoreText(
              description,
              trimLines: 3,
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
            sh5,
            // Interaction icons
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.silver,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        likeImage,
                        scale: 4,
                      ),
                      sw5,
                      Text(
                        '$likes',
                        style: h6.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                sw12,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.silver,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        dislikesImage,
                        scale: 4,
                      ),
                      sw5,
                      Text(
                        '$dislikes',
                        style: h6.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                sw12,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.silver,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        commentsImage,
                        scale: 4,
                      ),
                      sw5,
                      Text(
                        '$comments',
                        style: h6.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
