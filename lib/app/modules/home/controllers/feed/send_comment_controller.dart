import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class SendCommentController extends GetxController {
  var _inProgress = false.obs; // Changed to RxBool
  bool get inProgress => _inProgress.value; // Updated getter to use .value

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _otpToken;
  String? get otpToken => _otpToken;

  Future<bool> sendComment(String userId, String modelType, String contentId,
      String comment, bool isReply, String? replyRef) async {
    if (_inProgress.value) { // Updated to use .value
      return false;
    }

    bool isSuccess = false;

    _inProgress.value = true; // Updated to use .value
    update();

    Map<String, dynamic> requestBody = {};

    print('reply reference : $replyRef');
    if (replyRef == null || replyRef.isEmpty) {
      requestBody = {
        "user": userId,
        "model_type": modelType, // here modelType is: Wishlist | Feed | Reels
        "content": contentId, // post id
        "comment": comment,
        "isReply": isReply
      };
    } else {
      requestBody = {
        "user": userId,
        "model_type": modelType, // here modelType is: Wishlist | Feed | Reels
        "content": contentId, // post id
        "comment": comment,
        "isReply": isReply,
        "replyRef": replyRef
      };
    }

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.sendCommentUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress.value = false; // Updated to use .value
    update();
    return isSuccess;
  }
}