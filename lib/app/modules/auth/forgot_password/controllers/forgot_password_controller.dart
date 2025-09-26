// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // final OtpVerifyController otpVerifyController = OtpVerifyController();
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  // final Rx<CategoryModel?> _categoryModel = Rx<CategoryModel?>(null);
  // List<CategoryData>? get categoryData => _categoryModel.value!.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
  }

  String? _otpToken;
  String? get otpToken => _otpToken; 

  Future<bool> forgotPassword(String email) async {
    _inProgress.value = true;

    Map<String, dynamic> requestBody = {"email": email};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.forgotPasswordUrl, requestBody);

    if (response.isSuccess) {
      _errorMessage = null;

      print('Response roken');
      print(response.responseData['data']['verifyToken']);
      StorageUtil.saveData(
        StorageUtil.otpToken,
        response.responseData['data']['verifyToken'],
      );

      print('Response roken');
      print(response.responseData);

      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
