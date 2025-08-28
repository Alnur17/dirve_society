// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class OtpVerifyController extends GetxController {
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

  Future<bool> otpVerify(String otp) async {
    var token = await StorageUtil.getData(StorageUtil.otpToken);
    // final token = StorageUtil.getData(StorageUtil.userAccessToken);
    // if (token == null) {
    //   // Get.off(SignInScreen());
    //   return false;
    // }

    _inProgress.value = true;

    Map<String, dynamic> requestBody = {"otp": otp};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.otpVerifyUrl, requestBody, accesToken: token);

    if (response.isSuccess) {
      // delete otp token
      await StorageUtil.deleteData(StorageUtil.otpToken);
      _errorMessage = null;

      print('Response roken');
      print(response.responseData);
      StorageUtil.saveData(
        'reset-otp-token',
        response.responseData['data']['accessToken'],
      );

      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
