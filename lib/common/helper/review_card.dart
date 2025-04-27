import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_color/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final String imagePath;
  final int rating;
  final String reviewText;
  final String reviewerName;
  final String date;

  const ReviewCard({
    super.key,
    required this.imagePath,
    required this.rating,
    required this.reviewText,
    required this.reviewerName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.85,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: AppColors.darkRed,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reviewText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      AppImages.carImageFive,
                    ),
                  ),
                  sw8,
                  Text(
                    reviewerName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
