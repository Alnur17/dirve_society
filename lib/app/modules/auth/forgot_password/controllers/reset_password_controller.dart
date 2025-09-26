// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // final OtpVerifyController otpVerifyController = OtpVerifyController();
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  @override
  void onInit() {
    super.onInit();
  }

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> resetPassword(
      String email, String newPassword, String confirmPassword) async {
    _inProgress.value = true;

    Map<String, dynamic> requestBody = {
      "email": email,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.restePasswordUrl, requestBody,
            accesToken: StorageUtil.getData('reset-otp-token'));

    if (response.isSuccess) {
      _errorMessage = null;
      StorageUtil.deleteData('reset-otp-token');
      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
