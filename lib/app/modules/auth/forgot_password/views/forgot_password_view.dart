import 'package:dirve_society/app/modules/auth/forgot_password/controllers/forgot_password_controller.dart';
import 'package:dirve_society/app/modules/auth/forgot_password/views/otp_verify_view.dart';
import 'package:dirve_society/common/widgets/custom_background.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
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
              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  preIcon: Image.asset(
                    AppImages.message,
                    scale: 4,
                  ),
                  onChange: (String value) {},
                ),
              ),
              sh30,
              CustomButton(
                text: 'Send',
                onPressed: () {
                  otpVerifyFunction(_emailController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> otpVerifyFunction(String email) async {
    final bool isSuccess =
        await _forgotPasswordController.forgotPassword(email);

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Get.to(OtpVerifyView(email));
    } else {
      showSnackBarMessage(
        context,
        _forgotPasswordController.errorMessage ?? 'failed',
        true,
      );
    }
  }
}
