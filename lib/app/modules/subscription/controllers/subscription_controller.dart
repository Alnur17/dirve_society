// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _subscriptionId;
  String? get subcriptionId => _subscriptionId;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getSubscription(String id) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "user": StorageUtil.getData(StorageUtil.profileId),
      "package": id
    };

    final NetworkResponse response = await networkCaller.postRequest(
      Urls.subscriptionUrl,
      requestBody,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _subscriptionId = response.responseData['data']['_id'];
      _errorMessage = null;
      isSuccess = true;

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
