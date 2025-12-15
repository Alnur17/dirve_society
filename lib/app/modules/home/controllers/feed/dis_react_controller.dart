// ignore_for_file: avoid_print
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class DisReactPostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> disReactPost(String postId) async {
    print('Disliking post with ID: $postId');
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {};

    final NetworkResponse response = await Get.find<NetworkCaller>().patchRequest(
      Urls.disReactById(postId),
      body: requestBody,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null; 
      isSuccess = true;
      print('Dislike successful for postId: $postId');
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to dislike post';
      print('Dislike failed: $_errorMessage');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}