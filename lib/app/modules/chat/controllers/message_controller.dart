// message_controller.dart

import 'package:dirve_society/app/modules/chat/model/chat_message_model.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/network_caller/network_caller.dart';
import 'package:dirve_society/services/network_caller/network_response.dart';
import 'package:dirve_society/services/socket/socket_service.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';


class MessageController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final SocketService socketService = Get.put(SocketService());
  var isLoading = false.obs;

  var message = ChatMessageModel().obs; 
  var messageList = <MessageData>[].obs;

  Future<void> getMessages({required String chatId}) async {
    _inProgress = true;
    isLoading(true);
    update();

    String token = await StorageUtil.getData(StorageUtil.userAccessToken);

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.getMessagesUrl(chatId), accesToken: token);

    if (response.isSuccess) {
      messageList.clear();
      message.value = ChatMessageModel.fromJson(response.responseData);
      messageList.addAll(message.value.data ?? []);

      print('📦 Messages loaded from API: ${messageList.length}');
 
      // Clear socket messageList and populate with API messages 
      socketService.messageList.clear();

      
      // Api diye data ene messageList e add kora hoyeche
      for (final msg in messageList) {
        socketService.messageList.add({
          "id": msg.id.toString(),
          "text": msg.text ?? '',
          "imageUrl": msg.imageUrl,
          "seen": msg.seen,
          "senderId": msg.sender?.id?.toString(),
          "receiverId": msg.receiver?.id?.toString(),
          "chat": msg.chat.toString(),
          "createdAt": msg.createdAt?.toIso8601String() ??
              DateTime.now().toIso8601String(),
        });
       
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    isLoading(false);
    update();
  }

  // Method to send auto-message from therapist
  void sendAutoTherapistMessage({
    required String chatId,
    required String receiverId,
    required String therapistName,
  }) {
    // Check if auto-message was already sent for this chatId
    if (StorageUtil.getData('autoMessageSent_$chatId') == true) {
      print('📩 Auto-message already sent for chatId: $chatId');
      return;
    }

    final autoMessage = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "text":
          "Hi, I’m $therapistName. How are you feeling today?",
      "imageUrl": null,
      "seen": false,
      "senderId": receiverId, // Therapist is the sender
      "receiverId": null, // User's ID can be set if needed
      "chat": chatId,
      "createdAt": DateTime.now().toIso8601String(),
    };

    socketService.messageList.add(autoMessage);
    StorageUtil.saveData('autoMessageSent_$chatId', true); // Persist the flag
    print('📩 Auto-message from therapist added: ${autoMessage["text"]}');
  }
}
