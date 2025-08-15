import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Existing synchronous callback
  final Future<void> Function()? onPressedAsync; // New async callback
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final String? imageAssetPath;
  final double? borderRadius;
  final Color? iconColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, // Keep for synchronous callbacks
    this.onPressedAsync, // Add for asynchronous callbacks
    this.backgroundColor,
    this.textStyle,
    this.textColor,
    this.height = 48,
    this.width = double.infinity,
    this.borderColor,
    this.imageAssetPath,
    this.borderRadius = 40,
    this.iconColor,
    this.isLoading = false,
  }) : assert(
          onPressed == null || onPressedAsync == null,
          'Cannot provide both onPressed and onPressedAsync',
        ); // Ensure only one callback is provided

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || (onPressed == null && onPressedAsync == null)
          ? null
          : () {
              if (onPressed != null) {
                onPressed!(); // Call synchronous callback
              } else if (onPressedAsync != null) {
                onPressedAsync!(); // Call asynchronous callback
              }
            },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor ?? AppColors.transparent),
          color: backgroundColor ?? AppColors.darkRed,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading) ...[
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              ] else if (imageAssetPath != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    imageAssetPath!,
                    scale: 4,
                    color: iconColor,
                  ),
                ),
              ],
              Text(
                text,
                style: textStyle ??
                    h3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColor ?? AppColors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}