import 'package:dirve_society/app/modules/home/model/comment_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  var _inProgress = false.obs; // Changed to RxBool
  bool get inProgress => _inProgress.value; // Updated getter to use .value

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CommentModel? commentModel;
  List<CommentItemModel>? get commentData => commentModel?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> getAllComment(contentId) async {
    if (_inProgress.value) { // Updated to use .value
      return false;
    }

    bool isSuccess = false;

    _inProgress.value = true; // Updated to use .value
    update();

    Map<String, dynamic> params = {'limit': 200, 'page': 1};
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.commentByContentId(contentId),
        queryParams: params,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      print("Received Data: ${response.responseData}"); // Debug
      commentModel = CommentModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      print("Error: $_errorMessage");
    }

    _inProgress.value = false; // Updated to use .value
    update(); // UI update ensured
    return isSuccess;
  }
}