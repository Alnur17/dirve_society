import 'dart:developer';
import 'package:dirve_society/app/modules/chat/controllers/all_friend_controller.dart';
import 'package:dirve_society/app/modules/chat/views/message_view.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/services/socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final SocketService socketService = Get.put(SocketService()); 
  final FriendController friendController = Get.put(FriendController());
  final TextEditingController searchCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    super.initState();
    socketService.init();
    friendController.getAllFriends();

    searchCtrl.addListener(() {
      setState(() {
        search = searchCtrl.text;
      });
    });

    socketService.sokect.on(
      'chat-list::${StorageUtil.getData(StorageUtil.profileId)}',
      (data) {
        log('Socket chatlist data received ...............');
        log('Raw data: $data');
        _handleIncomingFriends(data);
      },
    );
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void _handleIncomingFriends(dynamic data) {
    if (data == null) return;

    if (data is List) {
      socketService.socketFriendtList.clear();
      for (var friend in data) {
        if (friend is Map<String, dynamic> && friend['chat'] != null) {
          final chat = friend['chat'];
          final message = friend['message'];
          final participants = chat['participants'] as List? ?? [];
          final participant = participants.isNotEmpty ? participants[0] : null;

          socketService.socketFriendtList.add({
            "id": chat['_id']?.toString() ?? '',
            "receiverId": participant?['_id']?.toString() ?? '',
            "name": participant?['name'] ?? 'No Name',
            "email": participant?['email'] ?? '',
            "profileImage": participant?['photoUrl'] ?? '',
            "createdAt": chat['createdAt'] ?? DateTime.now().toIso8601String(),
            "lastMessage": message != null ? message['text'] ?? 'No Message' : 'No Message',
            "lastMessageTime": message != null
                ? message['createdAt'] ?? DateTime.now().toIso8601String()
                : DateTime.now().toIso8601String(),
            "isSeen": message != null ? message['seen'] ?? false : false,
            "unreadMessageCount": friend['unreadMessageCount'] ?? 0,
          });
        }
      }
      socketService.socketFriendtList.refresh();
    } else if (data is Map<String, dynamic>) {
      final chat = data['chat'];
      final message = data['message'];
      final participants = chat?['participants'] as List? ?? [];
      final participant = participants.isNotEmpty ? participants[0] : null;

      final newFriend = {
        "id": chat?['_id']?.toString() ?? '',
        "receiverId": participant?['_id']?.toString() ?? '',
        "name": participant?['name'] ?? 'No Name',
        "email": participant?['email'] ?? '',
        "profileImage": participant?['photoUrl'] ?? '',
        "createdAt": chat?['createdAt'] ?? DateTime.now().toIso8601String(),
        "lastMessage": message != null ? message['text'] ?? 'No Message' : 'No Message',
        "lastMessageTime": message != null
            ? message['createdAt'] ?? DateTime.now().toIso8601String()
            : DateTime.now().toIso8601String(),
        "isSeen": message != null ? message['seen'] ?? false : false,
        "unreadMessageCount": data['unreadMessageCount'] ?? 0,
      };

      final existingIndex = socketService.socketFriendtList.indexWhere(
        (f) => f['id'] == newFriend['id'],
      );

      if (existingIndex != -1) {
        socketService.socketFriendtList[existingIndex] = newFriend;
      } else {
        socketService.socketFriendtList.add(newFriend);
      }
      socketService.socketFriendtList.refresh();
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
        title: Text(
          'Chat List',
          style: h4.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.borderColor),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value; // Update search query
                    });
                  },
                ),
              ),
            ),
            sh16,
            Expanded(
              child: ChatList(search: search),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final String search;

  const ChatList({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    final SocketService socketService = Get.find<SocketService>();
    final FriendController friendController = Get.find<FriendController>();

    return Obx(() {
      final friendList = socketService.socketFriendtList;

      if (friendController.inProgress.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredFriends = friendList.where((friend) {
        final name = friend['name']?.toLowerCase() ?? '';
        return search.isEmpty || name.contains(search.toLowerCase());
      }).toList();

      if (filteredFriends.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.search,
                height: 80,
                width: 95,
              ),
              Text(
                'No results for "${search.isEmpty ? 'Chats' : search}"',
                style: h4.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              sh16,
              Text(
                'We couldn’t find any matching chats. Please refine your search or check back later.',
                style: h6.copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
        itemCount: filteredFriends.length,
        itemBuilder: (context, index) {
          final friend = filteredFriends[index];
          final String chatId = friend['id'] ?? '';
          final String receiverId = friend['receiverId'] ?? '';
          final String receiverName = friend['name'] ?? 'No Name';
          final String receiverImage = friend['profileImage'] ?? '';
          final String lastMessage = friend['lastMessage'] ?? 'No Message';
          final int unreadMessageCount = friend['unreadMessageCount'] ?? 0;

          String formattedTime = '';
          try {
            final timestamp = DateTime.parse(friend['lastMessageTime'] ?? DateTime.now().toIso8601String());
            formattedTime = DateFormat('MMM d, HH:mm').format(timestamp);
          } catch (e) {
            formattedTime = DateFormat('MMM d, HH:mm').format(DateTime.now());
          }

          return GestureDetector(
            onTap: () {
              Get.to(() => MessageView(
                    chatId: chatId,
                    receiverId: receiverId,
                    receiverName: receiverName,
                    receiverImage: receiverImage,
                  ));
              log('message index is $index');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8, top: index == 0 ? 0 : 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.bottomNavbar,
                border: Border.all(color: AppColors.silver),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: receiverImage.isNotEmpty
                      ? NetworkImage(receiverImage)
                      : const AssetImage('assets/images/default_user.png') as ImageProvider,
                ),
                title: Text(
                  receiverName,
                  style: h4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black100,
                  ),
                ),
                subtitle: Text(
                  lastMessage,
                  style: h6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // trailing: unreadMessageCount > 0
                //     ? Container(
                //         padding: const EdgeInsets.all(8),
                //         decoration: ShapeDecoration(
                //           shape: const CircleBorder(),
                //           color: AppColors.darkRed,
                //         ),
                //         child: Text(
                //           '$unreadMessageCount',
                //           style: h6.copyWith(color: AppColors.white),
                //         ),
                //       )
                //     : null,
              ),
            ),
          );
        },
      );
    });
  }
}