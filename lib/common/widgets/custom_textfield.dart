import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomTextField extends StatefulWidget {
  final double? height;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Widget? sufIcon;
  final Widget? preIcon;
  final ValueChanged<String>? onChanged; // Changed to match naming convention
  final double borderRadius;
  final Color? containerColor;
  final Color? borderColor;
  final bool isPassword;
  final Color? textColor;
  final int? maxLines; // Corrected naming to match common usage
  final TextInputType? keyboardType; // Added to allow custom keyboard types

  const CustomTextField({
    super.key,
    this.height = 48,
    this.controller,
    this.hintText,
    this.hintTextStyle,
    this.sufIcon,
    this.preIcon,
    this.onChanged ,
    this.borderRadius = 12,
    this.containerColor,
    this.borderColor,
    this.isPassword = false,
    this.textColor,
    this.maxLines = 1,
    this.keyboardType, required ValueChanged<String> onChange,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: widget.borderColor ?? AppColors.borderColor),
        color: widget.containerColor,
      ),
      child: TextField(
        textInputAction: TextInputAction.done,
        onChanged: widget.onChanged,
        controller: widget.controller,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType ?? (widget.isPassword
            ? TextInputType.text
            : TextInputType.text), // Default to number for price input
        obscureText: widget.isPassword ? _obscureText : false,
        style: TextStyle(color: widget.textColor ?? AppColors.black),
        decoration: InputDecoration(
          hintText: widget.hintText ?? '',
          hintStyle: widget.hintTextStyle ?? h5.copyWith(color: AppColors.black),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: widget.preIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.sufIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}