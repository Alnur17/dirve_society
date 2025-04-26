import 'package:dirve_society/app/modules/auth/forgot_password/views/otp_verify_view.dart';
import 'package:dirve_society/common/widgets/custom_background.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sh100,
              Text(
                'No worries!',
                style: h3.copyWith(color: AppColors.white),
              ),
              sh16,
              Text(
                'Enter your registered email address and we’ll send you instructions to reset your password. Let’s get you back on track quickly and securely!',
                style: h5.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              sh30,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email address',
                    style: h4.copyWith(color: AppColors.white),
                  )),
              sh8,
              CustomTextField(
                hintText: 'Enter your email',
                preIcon: Image.asset(
                  AppImages.message,
                  scale: 4,
                ),
              ),
              sh30,
              CustomButton(
                text: 'Send',
                onPressed: () {
                  Get.to(() => OtpVerifyView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
