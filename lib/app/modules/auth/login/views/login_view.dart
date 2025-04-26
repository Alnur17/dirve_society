import 'package:dirve_society/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_background.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../forgot_password/views/forgot_password_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Login',
          style: appBarStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sh116,
                Text(
                  'Hi, Welcome back!',
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                sh12,
                Text(
                  'Sign in to continue exploring the best deals',
                  style: h4.copyWith(
                    color: AppColors.white,
                  ),
                ),
                sh40,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    const CustomTextField(
                      hintText: 'Your email',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Password',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    CustomTextField(
                      sufIcon: Image.asset(
                        AppImages.eyeClose,
                        scale: 4,
                      ),
                      hintText: '**********',
                    ),
                  ],
                ),
                sh16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: Image.asset(
                            AppImages.checkBoxCircle,
                            scale: 4,
                          ),
                        ),
                        sw16,
                        Text(
                          'Remember Me',
                          style: h4.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPasswordView());
                      },
                      child: Text(
                        'Forgot password?',
                        style: h4.copyWith(color: AppColors.darkRed),
                      ),
                    ),
                  ],
                ),
                sh24,
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    Get.to(() => const DashboardView());
                  },
                ),
                sh20,
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: h4.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Sign Up',
                        style: h4.copyWith(color: AppColors.darkRed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
