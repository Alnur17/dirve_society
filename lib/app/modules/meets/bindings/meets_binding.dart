import 'package:get/get.dart';

import '../controllers/meets_controller.dart';

class MeetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetsController>(
      () => MeetsController(),
    );
  }
}
