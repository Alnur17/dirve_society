import 'dart:convert';

import 'package:dirve_society/app/data/api.dart';
import 'package:dirve_society/app/data/base_client.dart';
import 'package:dirve_society/app/modules/auth/forgot_password/views/otp_verify_view.dart';
import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_constant/app_constant.dart';
import 'package:dirve_society/common/local_store/local_store.dart';
import 'package:dirve_society/common/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;

  Future<void> signUpController({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      final map = {
        "name": name,
        "email": email.toLowerCase(),
        "email": phoneNumber,
        "password": password,
      };

      final headers = {
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.register,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {

        final signUpToken = responseBody['data']['otpToken']['token'].toString();

        debugPrint("signUpToken >>: $signUpToken");
        LocalStorage.saveData(key: AppConstant.signUpToken, data: signUpToken);


        Get.to(() => OtpVerifyView());
      } else {
        throw 'Sign up Failed!';
      }
    } catch (e) {
      print("Catch Error: $e");
      kSnackBar(message: e.toString(), bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }
}
