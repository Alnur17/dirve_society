import 'package:dirve_society/app/modules/auth/login/views/login_view.dart';
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
        Get.to(() => LoginView());
      });
    } else {
      position.value = 0.0;
    }
  }
}
