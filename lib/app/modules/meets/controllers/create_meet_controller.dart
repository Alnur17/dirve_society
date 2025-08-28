// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

class CreateMeetController extends GetxController {
  // Changed to RxBool for reactive state management
  RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value; // Updated getter to use .value

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// 🔁 Create Meet Function
  Future<bool> createMeet(
      String title,
      String description,
      String location,
      String modelType,
      String reference,
      int entryFee,
      dynamic date,
      dynamic time,
      dynamic lat,
      dynamic lon,
      File? image,
      {File? cover}) async {
    if (_inProgress.value) {
      // Prevent multiple calls while in progress
      return false;
    }

    bool isSuccess = false;
    _inProgress.value = true; // Updated to use .value
    update();

    try {
      String? token = StorageUtil.getData(StorageUtil.userAccessToken);
      if (token == null || token.isEmpty) {
        _errorMessage = "User not authenticated";
        _inProgress.value = false; // Updated to use .value
        update();
        return false;
      }

      var uri = Uri.parse(Urls.createMeetUrl);
      var request = http.MultipartRequest('POST', uri);

      // ✅ Only Authorization header
      request.headers['Authorization'] = token;

      // ✅ Set 'data' field with JSON-encoded string
      Map<String, dynamic> jsonFields = {
        "title": title,
        "eventDetails": description,
        "modelType": modelType,
        "location": location,
        "reference": reference,
        "entryFee": entryFee,
        "time": time,
        "date": date,
        "latitude": lat,
        "longitude": lon
      };

      request.fields['data'] = jsonEncode(jsonFields);

      // ✅ Add image if available
      if (image != null) {
        print('Image ache ekhane ................................');
        print(image);
        String imagePath = image.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'content', // 🔑 Backend should expect this key
            imagePath,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // 📡 Send request
      var streamedResponse = await request.send();
      var responseBody = await streamedResponse.stream.bytesToString();

      print(responseBody);

      var decodedResponse = jsonDecode(responseBody);

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = decodedResponse['message'] ?? "Failed to create meet";
      }
    } catch (e) {
      _errorMessage = "Error creating meet: $e";
    } finally {
      _inProgress.value = false; // Updated to use .value
      update();
    }

    return isSuccess;
  }
}
