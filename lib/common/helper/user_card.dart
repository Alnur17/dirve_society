import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class UserCard extends StatelessWidget {
  final String title;
  final double rating;
  final String description;
  final bool isAdded;
  final VoidCallback onButtonPressed;

  const UserCard({
    super.key,
    required this.title,
    required this.rating,
    required this.description,
    required this.isAdded,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(AppImages.carImage),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: h1.copyWith(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColors.darkRed,
              ),
              sw5,
              Text(
                rating.toString(),
                style: h3,
              ),
            ],
          ),
          sh5,
          Text(
            description,
            style: h6.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          sh12,
          CustomButton(
            height: 32,
            text: isAdded ? 'Remove' : '+ Add',
            onPressed: onButtonPressed,
            backgroundColor: isAdded ? AppColors.grey : AppColors.darkRed,
          ),
        ],
      ),
    );
  }
}