// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'package:dirve_society/app/modules/profile/model/profile_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final NetworkCaller networkCaller = Get.put(NetworkCaller());

  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String? get errorMessage =>
      _errorMessage.value.isEmpty ? null : _errorMessage.value;

  final Rx<ProfileDetailsModel?> profileModel = Rx<ProfileDetailsModel?>(null);
  final Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  String? _otpToken;
  String? get otpToken => _otpToken;

  @override
  void onInit() {
    super.onInit();
    // Bind profileData to profileModel's data field reactively
    ever(profileModel, (ProfileDetailsModel? model) {
      profileData.value = model?.data;
    });
  }

  Future<bool> fetchProfileData() async {
    _inProgress.value = true;

    final NetworkResponse response = await networkCaller.getRequest(
      Urls.profileUrl,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      _errorMessage.value = '';
      profileModel.value = ProfileDetailsModel.fromJson(response.responseData);
      print('Profile data: ${profileModel.value?.data}');

      // Save profile data to local storage
      final profile = profileModel.value?.data;
      if (profile != null) {
        if (profile.id != null)
          await StorageUtil.saveData(StorageUtil.profileId, profile.id);
        if (profile.name != null)
          await StorageUtil.saveData(StorageUtil.profileName, profile.name);
        if (profile.email != null)
          await StorageUtil.saveData(StorageUtil.profileEmail, profile.email);
          if (profile.email != null)
          await StorageUtil.saveData(StorageUtil.isPaid, profile.isPremiumAccount);
        if (profile.photoUrl != null)
          await StorageUtil.saveData(
              StorageUtil.profilePhotoUrl, profile.photoUrl);
        if (profile.bio != null)
          await StorageUtil.saveData(StorageUtil.profileBio, profile.bio);
        if (profile.address != null)
          await StorageUtil.saveData(
              StorageUtil.profileAddress, profile.address);
        if (profile.scores != null)
          await StorageUtil.saveData(StorageUtil.profileScores, profile.scores);
        if (profile.status != null)
          await StorageUtil.saveData(StorageUtil.profileStatus, profile.status);
        if (profile.dataId != null)
          await StorageUtil.saveData(StorageUtil.profileDataId, profile.dataId);
        if (profile.avgRating != null)
          await StorageUtil.saveData(
              StorageUtil.profileAvgRating, profile.avgRating);
        if (profile.coverPhoto != null)
          await StorageUtil.saveData(
              StorageUtil.profileCoverPhoto, profile.coverPhoto);
      }

      _inProgress.value = false;
      return true;
    } else {
      _errorMessage.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    _inProgress.value = true;

    Map<String, dynamic> requestBody = {"email": email};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.forgotPasswordUrl, requestBody);

    if (response.isSuccess) {
      _errorMessage.value = '';
      _otpToken = response.responseData['data']['verifyToken'];
      await StorageUtil.saveData(
        StorageUtil.otpToken,
        _otpToken,
      );

      print('Response token: $_otpToken');
      print('Response data: ${response.responseData}');

      _inProgress.value = false;
      return true;
    } else {
      _errorMessage.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
