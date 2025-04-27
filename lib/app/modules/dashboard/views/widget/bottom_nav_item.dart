import 'package:flutter/material.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class NavBarItem extends StatelessWidget {
  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;

  const NavBarItem({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
          scale: 4,
        ),
        sh5,
        Center(
          child: Text(
            label,
            style: h5.copyWith(
              color: isSelected ? AppColors.darkRed : AppColors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}