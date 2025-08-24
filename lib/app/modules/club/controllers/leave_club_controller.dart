// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class LeaveClubController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? lastPage;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> leaveClub(String clubId, String userId) async {
    print('clubId: $clubId, userId: $userId');
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {"user": userId};

    final NetworkResponse response = await networkCaller.patchRequest(
      Urls.leaveClubById(clubId),
      body: requestBody,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
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
