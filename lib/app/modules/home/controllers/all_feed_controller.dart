// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/home/model/all_feed_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class AllFeedController extends GetxController {
  // final OtpVerifyController otpVerifyController = OtpVerifyController();
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  final Rx<AllFeedModel?> _categoryModel = Rx<AllFeedModel?>(null);
  List<AllFeedItemModel>? get categoryData => _categoryModel.value!.data;

  @override
  void onInit() {
    getAllFeed();
    super.onInit();
  }

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getAllFeed() async {
    _inProgress.value = true;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allfeedUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;

      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
