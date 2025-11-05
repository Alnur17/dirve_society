import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class UserCard extends StatelessWidget {
  final String? addFriendName;
  final String title;
  final String rating;
  final String description;
  final bool isAdded;
  final VoidCallback acceptButton;
  final VoidCallback rejectedButton;
  final VoidCallback addFriendButton;
  final VoidCallback onUserDetails;
  final bool? isOneButton;
  final String? image;

  const UserCard({
    super.key,
    required this.title,
    required this.rating,
    required this.description,
    required this.isAdded,
    required this.acceptButton,
    required this.onUserDetails,
    this.isOneButton,
    required this.rejectedButton,
    required this.addFriendButton,
    this.image, this.addFriendName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUserDetails,
      child: Container(
        height: 300,
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(image ?? ''),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: h1.copyWith(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            sh12,
            isOneButton == true
                ? Container()
                : CustomButton(
                    height: 28,
                    text: 'Accecpt',
                    onPressed: acceptButton,
                    backgroundColor: const Color.fromARGB(255, 0, 109, 9),
                  ),
            SizedBox(
              height: 4,
            ),
            isOneButton == true
                ? CustomButton(
                    height: 28,
                    text: addFriendName ?? 'Add Friend',
                    onPressed: addFriendButton,
                    backgroundColor: AppColors.darkRed,
                  )
                : CustomButton(
                    height: 28,
                    text: 'Rejected',
                    onPressed: rejectedButton,
                    backgroundColor: AppColors.darkRed,
                  ),
          ],
        ),
      ),
    );
  }
}
