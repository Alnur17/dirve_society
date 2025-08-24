
// import 'package:get/get.dart';

// class MeetsController extends GetxController {

// }


import 'package:dirve_society/app/modules/meets/controllers/all_meet_controller.dart';
import 'package:dirve_society/app/modules/meets/controllers/meet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetsView extends StatelessWidget {
  const MeetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final MeetsController controller = Get.put(MeetsController());
    final AllMeetsController allMeetsController = Get.find<AllMeetsController>();

    return Scaffold(
      body: GetBuilder<AllMeetsController>(
        builder: (allMeetsController) {
          if (allMeetsController.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (allMeetsController.errorMessage != null) {
            return Center(
              child: Text(
                allMeetsController.errorMessage ?? 'Failed to load meets',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(23.76784914290362, 90.42213245820426),
                      zoom: 14,
                    ),
                    markers: controller.markers.value,
                    onMapCreated: (GoogleMapController mapController) {
                      controller.mapController = mapController;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                  ),
          );
        },
      ),
    );
  }
}