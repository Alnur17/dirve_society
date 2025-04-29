import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/services.dart';

import '../../../../common/app_text_style/styles.dart';

class MeetModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? tag;
  final String? dateTime;
  final LatLng location; // Back to LatLng for coordinates
  final String? address; // New field for the address string

  MeetModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.tag,
    this.dateTime,
    required this.location,
    this.address,
  });
}

class MeetsController extends GetxController {
  final Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  final RxBool isLoading = true.obs;
  GoogleMapController? mapController;

  // Sample meet locations
  final List<MeetModel> meets = [
    MeetModel(
      id: '1',
      title: 'Downtown Meetup',
      description: 'Join us for a networking event',
      imageUrl: 'assets/images/car image 3.jpg',
      tag: 'Free',
      dateTime: '4:37 PM',
      location: const LatLng(23.780001516290767, 90.42604646346597),
      address: '2439 GreenField Avenue, SpringField, IL 62704, USA',
    ),
    MeetModel(
      id: '2',
      title: 'Tech Conference',
      description: 'Annual tech gathering',
      imageUrl: 'assets/images/car image 3.jpg',
      tag: 'Paid',
      dateTime: '6:00 PM',
      location: const LatLng(23.765831340215257, 90.4222888010189),
      address: '1234 Tech Park, SpringField, IL 62704, USA',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  Future<void> loadMarkers() async {
    isLoading.value = true;

    try {
      final Set<Marker> markersSet = {};

      for (final meet in meets) {
        // Option 2: Use Widget-to-image conversion approach
        final Uint8List markerIcon = await createCustomMarkerFromWidget(meet);

        final marker = Marker(
          markerId: MarkerId(meet.id),
          position: meet.location,
          icon: BitmapDescriptor.bytes(markerIcon),
          onTap: () {
            _showMeetPopup(meet);
          },
        );
        markersSet.add(marker);
      }

      markers.value = markersSet;
    } catch (e) {
      print('Error loading markers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Widget to image conversion - easier to customize
  Future<Uint8List> createCustomMarkerFromWidget(MeetModel meet) async {
    const int markerWidth = 80; // Reduced from previous size
    const int markerHeight = 120; // Reduced from previous size

    // Load the car image first to use in the widget
    ui.Image carImage = await loadImageFromAsset(meet.imageUrl);

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Create a custom painter that will draw our marker with the spike
    final CustomMarkerPainter customMarkerPainter = CustomMarkerPainter(
      image: carImage,
      markerColor: Colors.black, // Customize marker color
      strokeColor: Colors.white, // Customize stroke color
    );

    // Draw the marker on the canvas
    customMarkerPainter.paint(
        canvas,
        Size(markerWidth.toDouble(),
            markerHeight.toDouble())); // Set appropriate size

    // Convert the canvas to an image
    final ui.Image markerImage =
        await pictureRecorder.endRecording().toImage(120, 160);
    final ByteData? byteData =
        await markerImage.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  // Helper method to load an image from asset
  Future<ui.Image> loadImageFromAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  void _showMeetPopup(MeetModel meet) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: Get.width * 0.8,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  meet.imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Tag (e.g., "Free")
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green, // Adjust color as needed
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    meet.tag ?? 'Free',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                meet.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                meet.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // Date and Time
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    meet.dateTime ?? '4:37 PM',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Location (using address field)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      meet.address ??
                          '2439 GreenField Avenue, SpringField, IL 62704, USA',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 38,
                      textStyle: h6.copyWith(color: AppColors.white),
                      text: 'Event Details',
                      onPressed: () {},
                    ),
                  ),
                  sw8,
                  Expanded(
                    child: CustomButton(
                      height: 38,
                      textStyle: h6.copyWith(color: AppColors.darkRed),
                      text: 'Message',
                      onPressed: () {},
                      backgroundColor: AppColors.transparent,
                      borderColor: AppColors.darkRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
// void _showMeetPopup(MeetModel meet) {
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         width: Get.width * 0.8,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 meet.imageUrl,
//                 fit: BoxFit.cover,
//                 height: 150,
//                 width: double.infinity,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 150,
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: const Icon(Icons.image_not_supported, size: 50),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               meet.title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               meet.description,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => Get.back(),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}

// Custom painter class for drawing the marker
class CustomMarkerPainter extends CustomPainter {
  final ui.Image image;
  final Color markerColor;
  final Color strokeColor;

  CustomMarkerPainter({
    required this.image,
    required this.markerColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Size for the circular part that will contain the image
    final double circleRadius = width / 2;
    final double circleTop = 0;
    final double circleCenter = width / 2;

    // Draw shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Shadow path
    final Path shadowPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter + 2, circleRadius + 2),
          radius: circleRadius))
      ..moveTo(circleCenter + 2, circleRadius * 2 + 2)
      ..lineTo(circleCenter + 2, height - 10)
      ..lineTo(circleCenter + 15, height - 30)
      ..lineTo(circleCenter - 15, height - 30)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw the pin/spike
    final Paint pinPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.fill;

    // Main pin path
    final Path pinPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter, circleRadius), radius: circleRadius))
      ..moveTo(circleCenter, circleRadius * 2)
      ..lineTo(circleCenter, height - 10)
      ..lineTo(circleCenter + 12, height - 30)
      ..lineTo(circleCenter - 12, height - 30)
      ..close();

    canvas.drawPath(pinPath, pinPaint);

    // Draw stroke around the marker
    final Paint strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(pinPath, strokePaint);

    // Clip for the image - just the circle part
    canvas.save();
    canvas.clipPath(Path()
      ..addOval(Rect.fromCircle(
          center: Offset(circleCenter, circleRadius),
          radius: circleRadius - 5)));

    // Draw the image inside the circle
    final double imageSize = (circleRadius - 5) * 2;
    final Rect imageRect = Rect.fromLTWH(
      5,
      5,
      imageSize,
      imageSize,
    );

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      Paint(),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MeetsView extends StatelessWidget {
  const MeetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final MeetsController controller = Get.put(MeetsController());

    return Scaffold(
      body: Obx(
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Center map to user location or refresh markers
      //     controller.loadMarkers();
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
