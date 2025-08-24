import 'dart:io';
import 'package:dirve_society/app/modules/club/controllers/create_club_controller.dart';
import 'package:dirve_society/app/modules/meets/controllers/create_meet_controller.dart';
import 'package:dirve_society/app/modules/meets/views/location_picker.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_club_controller.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/common/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location; // Added for reverse geocoding
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/upload_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';

class CreateMeetsView extends StatefulWidget {
  String? clubId;
  CreateMeetsView({super.key, this.clubId});

  @override
  State<CreateMeetsView> createState() => _CreateMeetsViewState();
}

class _CreateMeetsViewState extends State<CreateMeetsView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController entryFeeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String privacy = 'public';
  final CreateClubController createClubController =
      Get.put(CreateClubController());
  final MyClubController myClubController = Get.put(MyClubController());
  final CreateMeetController createMeetController =
      Get.put(CreateMeetController());

  final formKey = GlobalKey<FormState>();
  File? profileImage;
  File? coverImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Create Meet',
          style: appBarStyle,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh30,
                Text('Club Name', style: h5),
                sh8,
                CustomTextField(
                  controller: nameController,
                  hintText: 'Enter your club name',
                ),
                sh16,
                Text('Meet Link', style: h5),
                sh8,
                CustomTextField(
                  maxline: 5,
                  controller: descriptionController,
                  hintText: 'Meet Link',
                ),
                sh16,
                Text('Entry Fee', style: h5),
                sh8,
                CustomTextField(
                  controller: entryFeeController,
                  hintText: 'Enter entry fee',
                ),
                sh16,
                Text('Date', style: h5),
                sh8,
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && mounted) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(
                        color: selectedDate == null
                            ? AppColors.grey
                            : AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                sh16,
                Text('Time', style: h5),
                sh8,
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null && mounted) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedTime == null
                          ? 'Select Time'
                          : selectedTime!.format(context),
                      style: TextStyle(
                        color: selectedTime == null
                            ? AppColors.grey
                            : AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                sh16,
                Text('Location', style: h5),
                sh8,
                GestureDetector(
                  onTap: () async {
                    final LatLng? pickedLocation =
                        await _showLocationPicker(context);
                    if (pickedLocation != null && mounted) {
                      try {
                        // Perform reverse geocoding to get the place name
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                          pickedLocation.latitude,
                          pickedLocation.longitude,
                        );

                        // Extract a readable address or place name
                        Placemark placemark = placemarks.first;
                        String locationName = _formatPlaceName(placemark);

                        setState(() {
                          selectedLocation = pickedLocation;
                          locationController.text = locationName; // Set the place name
                        });
                      } catch (e) {
                        // Fallback to a generic message if geocoding fails
                        showSnackBarMessage(
                            context, 'Failed to get location name', true);
                        setState(() {
                          selectedLocation = pickedLocation;
                          locationController.text = 'Unknown Location';
                        });
                      }
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: locationController,
                      hintText: 'Tap to select location',
                    ),
                  ),
                ),
                sh16,
                Text('Cover Photo', style: h5),
                sh8,
                UploadWidget(
                  onTap: () {
                    _imagePickerHelper.showAlertDialog(context,
                        (File pickedImage) {
                      setState(() {
                        coverImage = pickedImage;
                      });
                    });
                  },
                  imagePath: AppImages.upload,
                  imageFile: coverImage,
                  label: 'Upload',
                ),
                sh100,
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomButton(
          text: 'Create',
          onPressed: () {
            createMeet();
          },
        ),
      ),
    );
  }

  Future<LatLng?> _showLocationPicker(BuildContext context) async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showSnackBarMessage(context, 'Location service is disabled', true);
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showSnackBarMessage(context, 'Location permission denied', true);
        return null;
      }
    }

    _locationData = await location.getLocation();
    LatLng initialPosition =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(
          initialPosition: initialPosition,
        ),
      ),
    );
  }

  // Helper method to format the placemark into a readable address
  String _formatPlaceName(Placemark placemark) {
    List<String> addressParts = [];

    // Add relevant parts of the address (customize as needed)
    if (placemark.name != null && placemark.name!.isNotEmpty) {
      addressParts.add(placemark.name!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      addressParts.add(placemark.country!);
    }

    // Join the parts into a readable string
    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Unknown Location';
  }

  Future<void> createMeet() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate == null ||
          selectedTime == null ||
          selectedLocation == null) {
        showSnackBarMessage(
            context, 'Please select date, time, and location', true);
        return;
      }

      // Check if location name is valid (not raw LatLng or 'Unknown Location')
      if (locationController.text.startsWith('Lat:') ||
          locationController.text == 'Unknown Location') {
        showSnackBarMessage(
            context, 'Please select a valid location name', true);
        return;
      }

      final bool isSuccess = await createMeetController.createMeet(
        nameController.text,
        descriptionController.text,
        locationController.text, // Send the generated location name
        'Club',
        widget.clubId ?? '',
        entryFeeController.text.isEmpty
            ? 0
            : int.parse(entryFeeController.text),
        selectedDate!.toIso8601String(),
        selectedTime!.format(context),
        selectedLocation!.latitude,
        selectedLocation!.longitude,
        coverImage,
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Club meet created successfully');
          myClubController.getMyClub();
          nameController.clear();
          entryFeeController.clear();
          descriptionController.clear();
          locationController.clear();
          privacy = 'public';
          coverImage = null;
          setState(() {
            selectedDate = null;
            selectedTime = null;
            selectedLocation = null;
          });
          Get.back();
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            createMeetController.errorMessage ?? 'Failed to create meet',
            true,
          );
        }
      }
    }
  }
}