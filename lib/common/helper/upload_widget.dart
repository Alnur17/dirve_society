import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../app_color/app_colors.dart';

class UploadWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath; // Placeholder (e.g., AppImages.upload)
  final File? imageFile;
  final String? networkImage;
  final String label;
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
    this.labelStyle, void Function()? onImageTap,
  });

  /// Full-screen preview with zoom & close button
  void _showImagePreview(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: imageFile != null
                    ? Image.file(imageFile!, fit: BoxFit.contain)
                    : Image.network(
                        networkImage!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          color: Colors.white70,
                          size: 60,
                        ),
                      ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageFile != null || (networkImage?.isNotEmpty ?? false);

    return GestureDetector(
      onTap: hasImage ? () => _showImagePreview(context) : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey),
          color: Colors.grey[50],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Local image
              if (imageFile != null)
                Expanded(
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              // Network image
              else if (networkImage != null && networkImage!.isNotEmpty)
                Expanded(
                  child: Image.network(
                    networkImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) => Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                )
              // Placeholder
              else
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        imagePath,
                        width: iconSize * 2,
                        height: iconSize * 2,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),

              // Label (only show if no image or you want it always)
              if (!hasImage || label.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    hasImage ? '' : label,
                    style: labelStyle ?? h5.copyWith(color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}