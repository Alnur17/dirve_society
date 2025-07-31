import 'dart:developer';
import 'package:dirve_society/app/modules/auth/forgot_password/controllers/otp_verify_controller.dart';
import 'package:dirve_society/app/modules/auth/login/views/login_view.dart';
import 'package:dirve_society/common/widgets/custom_background.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';

class OtpVerifyView extends StatefulWidget {
  final String email;
  const OtpVerifyView(this.email, {super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final OtpVerifyController _otpVerifyController =
      Get.put(OtpVerifyController());
  final TextEditingController otpCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        title: Text(
          'Veify',
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                sh100,
                // Text(
                //   'Verify Your Identity',
                //   style: h4.copyWith(color: AppColors.white),
                // ),
                // sh20,
                Text(
                  'Code has been send to ${widget.email}',
                  style: h5.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                sh30,
                PinCodeTextField(
                  controller: otpCtrl,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 45,
                    fieldWidth: 45,
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
                    otpVerifyFunction(otpCtrl.text);
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
      ),
    );
  } 

  Future<void> otpVerifyFunction(String otp) async {
    final bool isSuccess = await _otpVerifyController.otpVerify(otp);

    if (isSuccess) {
      showSnackBarMessage(context, 'Successfully done');
      Get.to(LoginView());
    } else {
      showSnackBarMessage(
        context,
        _otpVerifyController.errorMessage ?? 'failed',
        true,
      );
    }
  }
}
