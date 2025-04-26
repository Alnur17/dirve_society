import 'package:get/get.dart';

import 'package:dirve_society/app/modules/home/controllers/connect_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectController>(
      () => ConnectController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
