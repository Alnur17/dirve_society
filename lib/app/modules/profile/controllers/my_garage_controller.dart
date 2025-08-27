import 'package:get/get.dart';
import 'package:dirve_society/app/modules/profile/model/my_garage_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';

class MyGarageController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MyGarageModel? _myGarageModel;
  List<MyGarageItemModel>? get myGarageList => _myGarageModel?.data;

  final int _limit = 5;
  int page = 0;

  Future<bool> getMyGarage({Map<String, dynamic>? queryParamsData}) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    // Map all filter parameters from FilterController
    Map<String, dynamic> queryParams = {
      'limit': _limit,
      'page': page,
      'brand': queryParamsData?['Brands'],
      'year': queryParamsData?['Year'],
      'color': queryParamsData?['Colours'],
      'condition': queryParamsData?['Condition'],
      'minPrice': queryParamsData?['Min Price'],
      'maxPrice': queryParamsData?['Max Price'],
      'vehicleType': queryParamsData?['Vehicle Type'],
      'mileage': queryParamsData?['Mileage'],
      'transmission': queryParamsData?['Transmission'],
      'store': queryParamsData?['Store'],
      'rating': queryParamsData?['Reviews'],
    }..removeWhere((key, value) => value == null || value == '');

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.myGarageUrl,
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _myGarageModel = MyGarageModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to load data';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}