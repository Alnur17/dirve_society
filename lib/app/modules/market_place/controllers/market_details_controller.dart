// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/market_place/model/market_details_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class MarketplaceDetailsController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MarketPlaceDetailsModel? _marketPlaceDetailsModel;
  MarketDetailsData? get marketPlaceDetailsModel =>
      _marketPlaceDetailsModel?.data;

  int? lastPage;

  Future<bool> getMarketPlaceData(String id) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {
      'limit': 99999,
    };
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.getMarketPlaceUrlById(id),
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _marketPlaceDetailsModel =
          MarketPlaceDetailsModel.fromJson(response.responseData);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
