import 'package:dirve_society/app/modules/meets/model/all_meets_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class AllMeetsController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllMeetsModel? _allMeetsModel;
  List<AllMeetsItemModel>? get allMeetsList => _allMeetsModel?.data;

  final int _limit = 200;
  int page = 0;

  Future<bool> getMeet() async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    // Map<String, dynamic> queryParams = {'limit': _limit, 'page': page};
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.allMeetUrl, 
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _allMeetsModel = AllMeetsModel.fromJson(response.responseData);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
