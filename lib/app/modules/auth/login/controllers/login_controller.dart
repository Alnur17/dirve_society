import 'dart:convert';

import 'package:dirve_society/app/data/api.dart';
import 'package:dirve_society/app/data/base_client.dart';
import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_constant/app_constant.dart';
import 'package:dirve_society/common/local_store/local_store.dart';
import 'package:dirve_society/common/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      final map = {
        "email": email.toLowerCase(),
        "password": password,
      };

      final headers = {
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.login,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {

        final accessToken = responseBody['data']['accessToken'].toString();

        debugPrint("accessToken>>: $accessToken");
        LocalStorage.saveData(key: AppConstant.token, data: accessToken);


        Get.offAll(() => DashboardView());
      } else {
        throw 'Login Failed!';
      }
    } catch (e) {
      print("Catch Error: $e");
      kSnackBar(message: e.toString(), bgColor: AppColors.red);
    } finally {
      isLoading(false);
    }
  }
}
