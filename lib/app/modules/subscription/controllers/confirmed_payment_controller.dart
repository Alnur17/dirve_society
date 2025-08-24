import 'package:dirve_society/app/modules/subscription/model/confirmed_payment_response_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';


class ConfirmedPaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ConfirmedPaymentResponseModel? confirmedPaymentResponseModel;
  ConfirmedPaymentResponseItemModel? get paymentDetails =>
      confirmedPaymentResponseModel?.data;

  Future<bool> confirmPaymentfunction(String id) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.confirmedPaymentUrlsById(id),
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      confirmedPaymentResponseModel =
          ConfirmedPaymentResponseModel.fromJson(response.responseData);
      StorageUtil.saveData('payment-reference-id', id);
      print('My data is .............................');
      print(confirmedPaymentResponseModel?.data?.amount);
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
