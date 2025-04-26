import 'package:flutter/material.dart';

import '../app_text_style/styles.dart';

class CustomRowHeader extends StatelessWidget {
  const CustomRowHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final Widget subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: h4.copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: subtitle,
        ),
      ],
    );
  }
}



//style: h5.copyWith(color: AppColors.textColorBlue,fontWeight: FontWeight.bold),