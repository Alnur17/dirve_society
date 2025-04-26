import 'dart:developer';

import 'package:dirve_society/app/modules/auth/forgot_password/views/reset_password_view.dart';
import 'package:dirve_society/common/widgets/custom_background.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';

class OtpVerifyView extends GetView {
  const OtpVerifyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Forgot Password',
          style: appBarStyle,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              AppImages.back,
              scale: 4,
            ),
          ),
        ),
      ),
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sh100,
              Text(
                'Verify Your Identity',
                style: h4.copyWith(color: AppColors.white),
              ),
              sh20,
              Text(
                'For your security, verify the code sent to your registered contact. Let’s confirm it’s you!',
                style: h5.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              sh30,
              PinCodeTextField(
                length: 4,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 70,
                  fieldWidth: 60,
                  // Reduce the width slightly for the gap
                  activeColor: AppColors.white,
                  activeFillColor: AppColors.white,
                  inactiveColor: AppColors.borderColor,
                  inactiveFillColor: AppColors.white,
                  selectedColor: AppColors.blue,
                  selectedFillColor: AppColors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: AppColors.transparent,
                cursorColor: AppColors.blue,
                enablePinAutofill: true,
                enableActiveFill: true,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  log("Allowing to paste $text");
                  return true;
                },
                appContext: context,
              ),
              sh20,
              CustomButton(
                text: 'Confirm',
                onPressed: () {
                  Get.to(() => const ResetPasswordView());
                },
              ),
              sh30,
              Text(
                'Resend code in 53s',
                style: h3.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
