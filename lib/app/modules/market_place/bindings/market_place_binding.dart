import 'package:get/get.dart';

import '../controllers/market_place_controller.dart';

class MarketPlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketPlaceController>(
      () => MarketPlaceController(),
    );
  }
}
