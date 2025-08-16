import 'package:dirve_society/app/modules/chat/controllers/message_controller.dart';
import 'package:dirve_society/app/modules/chat/controllers/message_send_controller.dart';
import 'package:dirve_society/app/modules/profile/controllers/profile_controller.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';

class MessageView extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;

  const MessageView({
    super.key,
    required this.chatId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController messageController = TextEditingController();
  final MessageController messageFetchController = Get.put(MessageController());
  final MessageSendController messageSendController =
      Get.put(MessageSendController());
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSending = false;
  bool isTextEmpty = true;
  String updatesenderId = '';
  String updatereceiverId = '';
  late String senderId;

  @override
  void initState() {
    super.initState();
    // Initialize senderId and socket connection
    senderId = StorageUtil.getData(StorageUtil.profileId) ?? '';
    print('Sender ID: $senderId');

    socketService.init(); // Initialize the socket connection
    updatesenderId = senderId;
    updatereceiverId = widget.receiverId;

    // Listen for incoming messages from the socket
    socketService.sokect.on('new-message::${widget.chatId}', (data) {
      print('Socket data received ...............');
      updatesenderId = data['sender'];
      updatereceiverId = data['receiver'];
      print('senderId: ${data['sender']}');
      print('receiverId: ${data['receiver']}');
      _handleIncomingMessage(data);
    });

    socketService.sokect
        .on('chat-list::${StorageUtil.getData(StorageUtil.userId)}', (data) {
      print('Socket chatlist data received ...............');
      print(data);
      _handleIncomingFriends(data);
    });

    // Fetch initial messages from the server
    messageFetchController.getMessages(chatId: widget.chatId).then((_) {
      if (messageFetchController.messageList.isEmpty) {
        messageFetchController.sendAutoTherapistMessage(
          chatId: widget.chatId,
          receiverId: widget.receiverId,
          therapistName: widget.receiverName,
        );
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    });

    // Track text field content
    messageController.addListener(() {
      setState(() {
        isTextEmpty = messageController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    socketService.sokect.off('new-message::${widget.chatId}');
    super.dispose();
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleIncomingMessage(dynamic data) {
    if (data['createdAt'] == null) {
      data['createdAt'] = DateTime.now().toIso8601String();
    }
    socketService.messageList.add(data);
    _scrollToEnd();
  }

  void _handleIncomingFriends(dynamic data) {}

  Future<void> sendMessageBTN(
      String chatId, String text, String receiverId) async {
    if (_formKey.currentState!.validate() &&
        !isSending &&
        text.trim().isNotEmpty) {
      setState(() {
        isSending = true;
      });

      socketService.sokect.emit('send-message', {
        'text': text,
        'sender': senderId,
        'receiver': receiverId,
      });

      socketService.sokect
          .on('chat-list::${StorageUtil.getData(StorageUtil.userId)}', (data) {
        print(
            'Chat list data er socket data ...................................................f\n$data');
      });

      socketService.sokect.on('new-message::${widget.chatId}', (data) {
        print(data);
      });

      messageController.clear();

      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    } else if (text.trim().isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
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
        titleSpacing: 8,
        title: Text(
          widget.receiverName, // Use dynamic receiver name
          style: const TextStyle(color: Colors.black),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: CustomCircularContainer(
        //       imagePath: widget.receiverImage, // Use dynamic receiver image
        //       backgroundColor: AppColors.silver,
        //       onTap: () {
        //         // Navigate to action screen or similar functionality
        //         // Example: Get.to(ActionScreen(...));
        //       },
        //     ),
        //   ),
        //   sw12,
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (messageFetchController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (socketService.messageList.isEmpty) {
                return const Center(child: Text('No Messages Found'));
              }

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: socketService.messageList.length,
                itemBuilder: (context, index) {
                  final message = socketService.messageList[index];
                  var senderId = message['senderId'] ?? message['sender'];
                  String formattedTime = '';
                  try {
                    final timestamp = DateTime.parse(message['createdAt'] ??
                        DateTime.now().toIso8601String());
                    formattedTime =
                        DateFormat('MMM d, HH:mm').format(timestamp);
                  } catch (e) {
                    formattedTime =
                        DateFormat('MMM d, HH:mm').format(DateTime.now());
                  }

                  if (senderId == this.senderId) {
                    return _buildSentMessage(
                      message: message['text'] ?? '',
                      time: formattedTime,
                    );
                  } else {
                    return _buildReceivedMessage(
                      message: message['text'] ?? '',
                      time: formattedTime,
                    );
                  }
                },
              );
            }),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(
      {required String message, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        sh5,
        Container(
          margin: const EdgeInsets.only(bottom: 8, right: 80),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: h5.copyWith(color: AppColors.black),
            ),
          ),
        ),
        sh16,
      ],
    );
  }

  Widget _buildSentMessage({required String message, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.check,
                color: Colors.blue,
                size: 18,
              ),
            ],
          ),
        ),
        sh5,
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8, left: 80),
          decoration: BoxDecoration(
            color: AppColors.darkRed,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: h5.copyWith(color: AppColors.white),
          ),
        ),
        sh16,
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Image.asset(
              AppImages.attachFile,
              scale: 4,
            ),
            sw12,
            Expanded(
              child: CustomTextField(
                controller: messageController,
                hintText: 'Message',
                borderRadius: 30,
                containerColor: AppColors.bottomNavbar,
                // validator: (value) {
                //   if (value == null || value.trim().isEmpty) {
                //     return 'Message cannot be empty';
                //   }
                //   return null;
                // },
              ),
            ),
            sw12,
            GestureDetector(
              onTap: isSending || isTextEmpty
                  ? null
                  : () {
                      sendMessageBTN(
                        widget.chatId,
                        messageController.text,
                        widget.receiverId,
                      );
                    },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColors.silver,
                ),
                child: isSending
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.send, color: isTextEmpty ? Colors.grey : null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
