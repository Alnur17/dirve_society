import 'package:get/get.dart';

import 'package:dirve_society/app/modules/chat/controllers/message_controller.dart';

import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
  }
}
