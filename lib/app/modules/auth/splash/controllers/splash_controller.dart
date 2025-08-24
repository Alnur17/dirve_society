import 'package:dirve_society/app/modules/auth/login/views/login_view.dart';
import 'package:dirve_society/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:dirve_society/app/modules/dashboard/views/dashboard_view.dart';
import 'package:dirve_society/common/app_constant/app_constant.dart';
import 'package:dirve_society/common/local_store/local_store.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  var position = 0.0.obs;
  var isSwiped = false.obs;
  var maxSwipe = 200.0.obs;

  void setMaxSwipe(double containerWidth, double buttonWidth) {
    maxSwipe.value = (containerWidth - buttonWidth).clamp(0, double.infinity);
  }

  void onDragUpdate(double delta) {
    position.value += delta;
    position.value = position.value.clamp(0.0, maxSwipe.value);
  }

  void onDragEnd() {
    if (position.value >= maxSwipe.value) {
      isSwiped.value = true;
      position.value = maxSwipe.value;
      Future.delayed(Duration(milliseconds: 100), () {

        String? token = StorageUtil.getData(StorageUtil.userAccessToken);
        print('user token is $token');
        debugPrint(token);
        if(token != null){       
          Get.offAll(() => DashboardView());
        }else{
         Get.offAll(() => LoginView());
        }

      });
    } else {
      position.value = 0.0;
    }
  }
}
