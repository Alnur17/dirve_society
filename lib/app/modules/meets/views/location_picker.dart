
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const LocationPickerScreen({required this.initialPosition});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng selectedPosition;

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.initialPosition,
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  selectedPosition = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: selectedPosition,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.mainColor.withOpacity(0.8),
              child: Text(
                'Lat: ${selectedPosition.latitude.toStringAsFixed(6)}, Lng: ${selectedPosition.longitude.toStringAsFixed(6)}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          text: 'Confirm Location',
          onPressed: () {
            Navigator.pop(context, selectedPosition);
          },
        ),
      ),
    );
  }
}
