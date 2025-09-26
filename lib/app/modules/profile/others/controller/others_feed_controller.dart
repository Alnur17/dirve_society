// ignore_for_file: avoid_print
import 'package:dirve_society/app/modules/home/model/all_feed_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';

class OthersClubFeedController extends GetxController {
  final NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AllFeedModel? postList;
  List<AllFeedItemModel>? get allPostList => postList?.data;

  String? _otpToken;
  String? get otpToken => _otpToken;

  final int _limit = 5;
  int page = 0;

  int? lastPage;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> getOthersAllClubFeed(String id) async {
    if (_inProgress) {
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {'limit': _limit, 'page': page};
    final NetworkResponse response = await networkCaller.getRequest(
      Urls.allClubFielsById(id, 'user'),
      queryParams: queryParams,
      accesToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );

    if (response.isSuccess) {
      postList = AllFeedModel.fromJson(response.responseData);
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
