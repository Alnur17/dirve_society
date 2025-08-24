import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../app_color/app_colors.dart';

class UploadWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath; // Placeholder image (e.g., AppImages.upload)
  final File? imageFile; // Locally picked image
  final String? networkImage; // API-fetched image URL
  final String label; // Label, always "Upload"
  final double height;
  final double width;
  final double iconSize;
  final TextStyle? labelStyle;

  const UploadWidget({
    super.key,
    required this.onTap,
    required this.imagePath,
    this.imageFile,
    this.networkImage,
    required this.label,
    this.height = 140,
    this.width = double.infinity,
    this.iconSize = 20,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display local file if picked
            if (imageFile != null)
              Expanded(
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              )
            // Display network image if available and no local file
            else if (networkImage != null && networkImage!.isNotEmpty)
              Expanded(
                child: Image.network(
                  networkImage!,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                  ),
                ),
              )
            // Display placeholder if no image is available
            else
              Container(
                height: iconSize,
                width: iconSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imagePath,
                  scale: 4,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              label,
              style: labelStyle ?? h5.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}