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
import '../../sign_up/views/sign_up_view.dart';

class LoginView extends GetView {
   LoginView({super.key});

  final TextEditingController emailController = TextEditingController(text: "emonhasan7650@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "user123");

  final LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {

    final RxBool isRememberMeChecked = false.obs;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Login',
          style: appBarStyle.copyWith(color: AppColors.white),
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
                    CustomTextField(
                      hintText: 'Your email',
                      controller: emailController,
                      onChange: (value) {
                        // Handle email input if needed
                      },
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
                      hintText: '**********',
                      isPassword: true,
                      controller: passwordController,
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
                            isRememberMeChecked.value = !isRememberMeChecked.value;
                          },
                          child: Obx(
                                () =>
                              isRememberMeChecked.value
                                  ? Icon(Icons.check_box_outline_blank, color: AppColors.white) // Update to checked image if available
                                  : Icon(Icons.check_box,color: AppColors.white,) ,

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
                Obx(() =>  CustomButton(
                  isLoading: loginController.isLoading.value,
                  text: 'Login',
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      loginController.login(email: emailController.text.trim(), password: passwordController.text.trim());

                    } else {
                      Get.snackbar(
                        'Error',
                        'Please enter both email and password',
                        backgroundColor: AppColors.darkRed,
                        colorText: AppColors.white,
                      );
                    }
                  },
                ),),
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