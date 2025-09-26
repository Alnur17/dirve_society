import 'package:get/get.dart';
import 'package:dirve_society/app/modules/profile/model/my_garage_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';

class OthersGarageController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MyGarageModel? _myGarageModel;
  List<MyGarageItemModel>? get myGarageList => _myGarageModel?.data;

  Future<bool> getOthersGarage({required String id}) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    // Map all filter parameters from FilterController
    Map<String, dynamic> queryParams = {
      "limit": 99999,
      "page": 1,
    };

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.otherGarageById(id),
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _myGarageModel = MyGarageModel.fromJson(response.responseData);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
