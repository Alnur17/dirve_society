// ignore_for_file: avoid_print

import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class CreateForumController extends GetxController {
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

  Future<bool> createForun(
      String title, String description, String clubId) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> jsonFields = {
      "author": StorageUtil.getData(StorageUtil.profileId),
      "club": clubId,
      "title": title,
      "description": description,
    };

    final NetworkResponse response = await networkCaller.postRequest(
      Urls.createForumUrl,
      jsonFields,
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
