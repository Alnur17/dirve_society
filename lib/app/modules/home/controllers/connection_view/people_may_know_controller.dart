// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/home/model/all_pending_connection_model.dart';
import 'package:dirve_society/app/modules/home/model/people_may_know_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class PeopleMayKnowController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PeopleYouMayModel? _peopleYouMayModel;
  List<PeopleYouMayItemModel>? get peopleYouMayList => _peopleYouMayModel?.data;

  int? lastPage;

  @override
  void onInit() {
    getPeopleMayKnow();
    super.onInit();
  }

  Future<bool> getPeopleMayKnow() async {
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
      Urls.peopleMayKnowUrl,
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _peopleYouMayModel = PeopleYouMayModel.fromJson(response.responseData);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
