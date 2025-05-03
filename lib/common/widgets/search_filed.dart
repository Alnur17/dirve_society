import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import 'custom_textfield.dart';

class SearchFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchFiled({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChange: onChanged,
      hintText: 'Search...',
      borderRadius: 30,
      preIcon: Image.asset(
        AppImages.search,
        scale: 4,
        color: AppColors.grey,
      ),
    );
  }
}
