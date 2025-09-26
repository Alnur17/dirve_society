import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../widgets/custom_button.dart';

class GroupCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String memberCount;
  final bool isPublic;
  final bool isJoined;
  final VoidCallback acceptButton;
  final VoidCallback rejectedButton;
  final VoidCallback joinClubBtuton;
  final VoidCallback? ontap; // Made nullable
  final bool showButton; // New parameter to control button visibility
  final bool isOneButton;

  const GroupCard({
    super.key,
    required this.title,
    required this.memberCount,
    required this.isPublic,
    required this.isJoined,
    this.showButton = true,
    this.ontap,
    required this.imageUrl,
    required this.isOneButton,
    required this.acceptButton,
    required this.rejectedButton,
    required this.joinClubBtuton, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
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
            // Group image placeholder
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: 10),
            // Title
            Text(
              title,
              style: h1.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            // Member count
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.groupLight,
                  scale: 4,
                ),
                Text(
                  memberCount,
                  style: h6.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            // Public/Private status
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.public,
                  scale: 4,
                ),
                SizedBox(width: 4),
                Text(
                  isPublic ? 'Public Club' : 'Private Club',
                  style: h6.copyWith(color: AppColors.grey),
                ),
              ],
            ),
            if (showButton) ...[
              SizedBox(height: 12),
              // Switchable Join Button
              CustomButton(
                height: 32,
                text: isOneButton ? 'Join' : 'Accept',
                onPressed: isOneButton ? joinClubBtuton : acceptButton,
                backgroundColor: const Color.fromARGB(255, 0, 109, 9),
              ),
              SizedBox(height: 4),
              isOneButton
                  ? Container()
                  : CustomButton(
                      height: 32,
                      text: 'Rejected',
                      onPressed: rejectedButton,
                      backgroundColor: AppColors.darkRed,
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
