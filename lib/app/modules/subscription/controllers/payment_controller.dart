import 'package:dirve_society/app/modules/subscription/model/payment_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';


class PaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  PaymentModel? paymentModel;
  PaymentModel? get paymentData => paymentModel;

  Future<bool> getPayment(
      String userId, String refereneId) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {
      "modelType": 'Order',
      "account": userId,
      "reference": refereneId
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest('Urls.paymentCheckoutUrl', requestBody,accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      paymentModel = PaymentModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
