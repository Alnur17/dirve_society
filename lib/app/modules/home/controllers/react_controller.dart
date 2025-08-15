// ignore_for_file: avoid_print
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class ReactPostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> reactPost(String postId) async {
    print('Reacting to post with ID: $postId');
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {};

    final NetworkResponse response = await Get.find<NetworkCaller>().patchRequest(
      Urls.reactById(postId),
      body: requestBody,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      print('Like successful for postId: $postId');
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to like post';
      print('Like failed: $_errorMessage');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}