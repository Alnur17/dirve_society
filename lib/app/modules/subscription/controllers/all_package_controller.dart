// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/subscription/model/all_package_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class AllPackageController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllPackageModel? _allPackageModel;
  List<AllPackageItemModel>? get allPackageList => _allPackageModel?.data;

  int? lastPage;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getAllPackage() async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.packageUrl,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _allPackageModel = AllPackageModel.fromJson(response.responseData);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
