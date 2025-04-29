import 'package:get/get.dart';

class ProfileController extends GetxController {

  var isPostSelected = true.obs;

  void toggleTab() {
    isPostSelected.value = !isPostSelected.value;
  }
}
