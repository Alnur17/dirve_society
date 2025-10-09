import 'package:dirve_society/app/modules/chat/controllers/add_chat_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/all_connection_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/add_connection_request_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/change_connection_status_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/people_may_know_controller.dart';
import 'package:dirve_society/app/modules/home/views/all_people_you_may_screen.dart';
import 'package:dirve_society/app/modules/profile/others/views/others_profile_screen.dart';
import 'package:dirve_society/common/helper/user_card.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectUserView extends StatefulWidget {
  const ConnectUserView({super.key});

  @override
  State<ConnectUserView> createState() => _ConnectUserViewState();
}

class _ConnectUserViewState extends State<ConnectUserView> {
  final AllPendingConnectionController allPendingController =
      Get.put(AllPendingConnectionController());

  final PeopleMayKnowController peopleMayKnowController =
      Get.put(PeopleMayKnowController());

  final AddConnectionRequestController addConnectionRequestController =
      Get.put(AddConnectionRequestController());

  final ChangeConnectionStatusController changeConnectionStatusController =
      Get.put(ChangeConnectionStatusController());

  final AddChatController addChatController = Get.put(AddChatController());

  @override
  void initState() {
    allPendingController.getAllPendingConnection();
    peopleMayKnowController.getPeopleMayKnow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Connect Requests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: GetBuilder<AllPendingConnectionController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.allPendingConnectionList == null ||
                    controller.allPendingConnectionList!.isEmpty) {
                  return const Center(
                    child: Text('No pending connections available'),
                  );
                }
                // Update buttonStates to match the list length

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.allPendingConnectionList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 200, // Ensure UserCard respects this width
                          child: UserCard(
                            image: controller.allPendingConnectionList![index]
                                    .user?.photoUrl ??
                                '',
                            title: controller.allPendingConnectionList![index]
                                    .user?.name ??
                                '',
                            rating: controller.allPendingConnectionList![index]
                                        .user!.avgRating ==
                                    null
                                ? 0.0.toString()
                                : controller.allPendingConnectionList![index]
                                            .user?.avgRating ==
                                        0
                                    ? 0.0.toString()
                                    : controller
                                            .allPendingConnectionList![index]
                                            .user
                                            ?.avgRating!
                                            .toString() ??
                                        '',
                            description: controller
                                    .allPendingConnectionList![index]
                                    .user
                                    ?.bio ??
                                '',
                            isAdded: true,
                            acceptButton: () {
                              changeConnectionRequest(
                                  userId: controller
                                          .allPendingConnectionList![index]
                                          .user!
                                          .id ??
                                      '',
                                  contentId: controller
                                          .allPendingConnectionList![index]
                                          .id ??
                                      '',
                                  status: 'approved');
                            },
                            addFriendButton: () {},
                            rejectedButton: () {
                              changeConnectionRequest(
                                  userId: controller
                                          .allPendingConnectionList![index]
                                          .user!
                                          .id ??
                                      '',
                                  contentId: controller
                                          .allPendingConnectionList![index]
                                          .id ??
                                      '',
                                  status: 'rejected');
                            },
                            onUserDetails: () {
                              Get.to(() => OthersProfileView(
                                    authorId: controller
                                            .allPendingConnectionList![index]
                                            .user!
                                            .id ??
                                        '',
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People you may know',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AllPeopleYouMayScreen());
                  },
                  child: Text(
                    'view all',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: GetBuilder<PeopleMayKnowController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.peopleYouMayList == null ||
                    controller.peopleYouMayList!.isEmpty) {
                  return const Center(
                    child: Text('No pending connections available'),
                  );
                }
                // Update buttonStates to match the list length

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.peopleYouMayList!.length < 4
                      ? controller.peopleYouMayList!.length
                      : 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: 200, // Ensure UserCard respects this width
                          child: UserCard(
                            image: controller.peopleYouMayList![index].photoUrl,
                            isOneButton: true,
                            title:
                                controller.peopleYouMayList![index].name ?? '',
                            rating: controller
                                .peopleYouMayList![index].ratingCount
                                .toString(),
                            description:
                                controller.peopleYouMayList![index].bio ?? '',
                            isAdded: true,
                            acceptButton: () {},
                            addFriendButton: () {
                              addUserRequest(
                                  userId: StorageUtil.getData(
                                      StorageUtil.profileId),
                                  modelType: 'User',
                                  reference:
                                      controller.peopleYouMayList![index].id ??
                                          '');
                            },
                            rejectedButton: () {},
                            onUserDetails: () {
                              Get.to(() => OthersProfileView(
                                    authorId: controller
                                            .peopleYouMayList![index].id ??
                                        '',
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addUserRequest(
      {required String userId,
      required String modelType,
      required String reference,
      String? repReference}) async {
    final bool isSuccess = await addConnectionRequestController.addClubRequest(
        userId, modelType, reference);
    if (isSuccess) {
      //  allPostController.updatePostHide(contentId, true);
      peopleMayKnowController.getPeopleMayKnow();
      if (mounted) {
        // showSnackBarMessage(context, 'Comment successfully posted');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            addConnectionRequestController.errorMessage ?? 'Failed', true);
      }
    }
  }

  Future<void> changeConnectionRequest(
      {required String contentId,
      required String status,
      required String userId}) async {
    final bool isSuccess = await changeConnectionStatusController
        .changeConnectionStatus(contentId, status);
    if (isSuccess) {
      status == 'approved' ? addChat(userId) : null;
      allPendingController.getAllPendingConnection();
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            addConnectionRequestController.errorMessage ?? 'Failed', true);
      }
    }
  }

  Future<void> addChat(String userId) async {
    final bool isSuccess = await addChatController.addChat(userId);

    if (isSuccess) {
      if (mounted) {}
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          addChatController.errorMessage ?? 'Failed to update profile',
          true,
        );
      }
    }
  }
}
