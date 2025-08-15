// ignore_for_file: avoid_print
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';


class SavePostController extends GetxController {
  
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> savePostF(
      String userId, String contentId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

   
    Map<String, dynamic> requestBody = {
      "user": userId,
      "content": contentId
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.favouriteUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
