// ignore_for_file: use_build_context_synchronously

import 'package:dirve_society/app/modules/auth/forgot_password/views/otp_verify_view.dart';
import 'package:dirve_society/app/modules/auth/sign_up/controllers/sign_up_controller.dart';
import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
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
import '../../login/views/login_view.dart';

class SignUpView extends GetView {
  SignUpView({super.key});

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    // You may want to use controllers to access the field values
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final addressController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Signup',
          style: appBarStyle.copyWith(color: AppColors.white),
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
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sh100,
                Text(
                  'Create New Account',
                  style: h2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                sh12,
                Text(
                  'Please fill your detail information.',
                  style: h4.copyWith(
                    color: AppColors.white,
                  ),
                ),
                sh16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    CustomTextField(
                       onChange: (String value) {  },
                      controller: nameController,
                      hintText: 'Enter your full name',
                    ),
                    sh12,
                    Text(
                      'Address',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    CustomTextField(
                       onChange: (String value) {  },
                      controller: addressController,
                      hintText: 'Your address',
                    ),
                    sh12,
                    Text(
                      'Email',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    CustomTextField(
                       onChange: (String value) {  },
                      controller: emailController,
                      hintText: 'Your email',
                    ),
                    sh12,
                    Text(
                      'Create a Password',
                      style: h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    sh8,
                    CustomTextField(
                       onChange: (String value) {  },
                      controller: passwordController,
                      sufIcon: Image.asset(
                        AppImages.eyeClose,
                        scale: 4,
                      ),
                      hintText: '**********',
                      isPassword: true,
                    ),
                    sh20,
                    Row(
                      children: [
                        Image.asset(
                          AppImages.checkBoxFilledSquare,
                          scale: 4,
                        ),
                        sw16,
                        Expanded(
                          child: Text(
                            'I agree to the Terms & Conditions and Privacy Policy',
                            style: h4.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                sh20,
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    signUpFunction(
                      context,
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      addressController.text.trim(),
                    );
                  },
                ),
                sh20,
                GestureDetector(
                  onTap: () {
                    // Get.offAll(() => LoginView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: h4.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Login',
                        style: h4.copyWith(color: AppColors.darkRed),
                      ),
                    ],
                  ),
                ),
                sh30,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpFunction(
    BuildContext context,
    String name,
    String email,
    String password,
    String address,
  ) async {
    final bool isSuccess = await signUpController.createUser(
      name,
      email,
      password,
      address,
    );

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      //  Get.offAll(() =>  LoginView());
      Get.to(OtpVerifyView(email));
    } else {
      showSnackBarMessage(
        context,
        signUpController.errorMessage ?? 'failed',
        true,
      );
    }
  }
}
