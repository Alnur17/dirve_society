import 'package:dirve_society/app/modules/profile/controllers/profile_controller.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:dirve_society/urls.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxController {
  late IO.Socket _socket;

  RxBool isLoading = false.obs;
  final ProfileController profileController = Get.put(ProfileController());

  final _messageList = <Map<String, dynamic>>[].obs;
  final _socketFriendList = <Map<String, dynamic>>[].obs;
  final _notificationsList = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get messageList => _messageList;
  RxList<Map<String, dynamic>> get socketFriendtList => _socketFriendList;
  RxList<Map<String, dynamic>> get notificationsList => _notificationsList;

  IO.Socket get sokect => _socket;

  Future<SocketService> init() async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    final userId = StorageUtil.getData('user-id');

    _socket = IO.io(Urls.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'token': token},
    });

    _socket.on('connect', (_) {
      print('✅ Connected to the server');
      _socket.emit("connection", userId);
    });

    _socket.onConnect((_) async {
      print('🟢 Socket connected');
      _socket.emit("connection", userId);
    });

    _socket.on('checking_notification', (data) {
      print('Check in data from socket');
      print(data);
    });

    _socket.onDisconnect((_) {
      print('🔴 Socket disconnected');
    });

    return this;
  }

  void disconnect() {
    _socket.disconnect();
  }
}
