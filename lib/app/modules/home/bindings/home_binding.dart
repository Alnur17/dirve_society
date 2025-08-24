import 'package:get/get.dart';

import 'package:dirve_society/app/modules/home/controllers/connection_view/connect_controller.dart';
import 'package:dirve_society/app/modules/market_place/controllers/filter_controller.dart';

import '../controllers/feed/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
    Get.lazyPut<ConnectController>(
      () => ConnectController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
