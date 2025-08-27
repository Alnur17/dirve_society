// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/club/model/all_invite_people_model.dart';
import 'package:dirve_society/app/modules/club/model/club_details_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class AllInvitePeopleController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllInvitePeopleModel? _allInvitePeopleModel;
  Data? get allInvitePeople => _allInvitePeopleModel?.data;

  int? lastPage;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getInvitePeople(String clubId) async {
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
      Urls.allInvitePeopleById(clubId),
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

      _allInvitePeopleModel = AllInvitePeopleModel.fromJson(response.responseData);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
