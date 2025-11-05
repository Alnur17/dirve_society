import 'package:get/get.dart';
import 'package:dirve_society/app/modules/profile/model/my_garage_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';

class FilterGarageController extends GetxController {
  final NetworkCaller networkCaller = Get.find();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MyGarageModel? _myGarageModel;
  List<MyGarageItemModel>? get myGarageList => _myGarageModel?.data;

  Future<bool> getMyGarage({Map<String, dynamic>? queryParamsData}) async {
    _inProgress = true;
    update();

    final Map<String, dynamic> queryParams = {
      'min_price': queryParamsData?['min_price'],
      'max_price': queryParamsData?['max_price'],
      'brand': queryParamsData?['brand'],
      'model': queryParamsData?['model'],
      'min_year': queryParamsData?['min_year'],
      'max_year': queryParamsData?['max_year'],
      'condition': queryParamsData?['condition'],
      'color': queryParamsData?['color'],
      'max_mileage': queryParamsData?['max_mileage'],
      'min_engine_size': queryParamsData?['min_engine_size'],
      'max_engine_size': queryParamsData?['max_engine_size'],
      'transmission': queryParamsData?['transmission'],
    }..removeWhere((key, value) => value == null || value.toString().isEmpty);

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.carUrl,
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _myGarageModel = MyGarageModel.fromJson(response.responseData);
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage ?? 'Failed to load';
    }

    _inProgress = false;
    update();
    return response.isSuccess;
  }
}