
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const LocationPickerScreen({required this.initialPosition, super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng selectedPosition;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
  }

  // Function to search for a location using Nominatim API
  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    final String url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'drive_society/1.0', // Replace with your app's name
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final double lat = double.parse(data[0]['lat']);
          final double lng = double.parse(data[0]['lon']);
          setState(() {
            selectedPosition = LatLng(lat, lng);
            _mapController.move(selectedPosition, 13.0);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location not found')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch location')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
          // FlutterMap(
          //   mapController: _mapController,
          //   options: MapOptions(
          //     initialCenter: widget.initialPosition,
          //     initialZoom: 13.0,
          //     onTap: (tapPosition, point) {
          //       setState(() {
          //         selectedPosition = point;
          //       });
          //     },
          //   ),
          //   children: [
          //     TileLayer(
          //       urlTemplate:
          //           'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          //       subdomains: const ['a', 'b', 'c'],
          //     ),
          //     MarkerLayer(
          //       markers: [
          //         Marker(
          //           width: 80.0,
          //           height: 80.0,
          //           point: selectedPosition,
          //           child: const Icon(
          //             Icons.location_pin,
          //             color: Colors.red,
          //             size: 40,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // Search bar at the top
          Positioned(
            top: 60, // Adjusted to ensure visibility
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location (e.g., Banani)',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchLocation(_searchController.text);
                    },
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  _searchLocation(value);
                },
              ),
            ),
          ),
          // Display selected coordinates
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}