// ignore_for_file: avoid_print
import 'package:dirve_society/app/modules/home/model/post_details_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class FeedDetailsController extends GetxController {
  final NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PostDetailsModel? postDetailsModel;
  PostData? get postData => postDetailsModel?.data;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getMyFeed(String id) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.feedsById(id),
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      postDetailsModel = PostDetailsModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
