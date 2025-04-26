
import 'package:get/get.dart';

class ConnectController extends GetxController {
  var isUsersSelected = true.obs;

  void toggleTab() {
    isUsersSelected.value = !isUsersSelected.value;
  }
}
