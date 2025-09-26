import 'package:dirve_society/app/modules/home/controllers/connection_view/add_connection_request_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/change_connection_status_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/discover_club_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/connection_view/my_joining_club_controller.dart';
import 'package:dirve_society/common/helper/group_card.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ConnectGroupView extends StatefulWidget {
  const ConnectGroupView({super.key});

  @override
  State<ConnectGroupView> createState() => _ConnectGroupViewState();
}

class _ConnectGroupViewState extends State<ConnectGroupView> {
  final DiscoverClubController discoverClubController =
      Get.put(DiscoverClubController());
  final MyJoiningClubController myJoiningClubController =
      Get.put(MyJoiningClubController());

  final AddConnectionRequestController addConnectionRequestController =
      Get.put(AddConnectionRequestController());
  final ChangeConnectionStatusController changeConnectionStatusController =
      Get.put(ChangeConnectionStatusController());

  @override
  void initState() {
    myJoiningClubController.getJoiningClub('pending');
    discoverClubController.getDiscoverClub();
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
            child: GetBuilder<MyJoiningClubController>(builder: (controller) {
              if (controller.inProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.myJoiningClubList == null ||
                  controller.myJoiningClubList!.isEmpty) {
                return const Center(
                  child: Text('No club requests available'),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.myJoiningClubList?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                          width: 200, // Ensure UserCard respects this width
                          child: GroupCard(
                            isOneButton: false,
                            acceptButton: () {
                              changeConnectionRequest(
                                  contentId:
                                      controller.myJoiningClubList![index].id ??
                                          '',
                                  status: 'approved');
                            },
                            joinClubBtuton: () {},
                            rejectedButton: () {
                              changeConnectionRequest(
                                  contentId:
                                      controller.myJoiningClubList![index].id ??
                                          '',
                                  status: 'rejected');
                            },
                            imageUrl: controller.myJoiningClubList![index]
                                    .reference?.profilePhoto ??
                                '',
                            title: controller.myJoiningClubList![index]
                                    .reference?.name ??
                                '',
                            memberCount: controller
                                    .myJoiningClubList![index].reference?.member
                                    .toString() ??
                                '',
                            isPublic: true,
                            isJoined: true,
                          )),
                    ),
                  );
                },
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Discover Popular Groups',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: GetBuilder<DiscoverClubController>(builder: (controller) {
              if (controller.inProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.discoverClubList == null ||
                  controller.discoverClubList!.isEmpty) {
                return const Center(
                  child: Text('No clubs available'),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.discoverClubList?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                          width: 200, // Ensure UserCard respects this width
                          child: GroupCard(
                            isOneButton: true,
                            acceptButton: () {},
                            joinClubBtuton: () {
                              addClubRequest(
                                userId:
                                    StorageUtil.getData(StorageUtil.profileId),
                                modelType: 'Club',
                                reference:
                                    controller.discoverClubList?[index].id ??
                                        '',
                              );
                            },
                            rejectedButton: () {},
                            imageUrl: controller
                                    .discoverClubList?[index].coverPhoto ??
                                '',
                            title:
                                controller.discoverClubList?[index].name ?? '',
                            memberCount:
                                '${controller.discoverClubList?[index].member} Members',
                            isPublic: true,
                            isJoined: false,
                          )),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> addClubRequest(
      {required String userId,
      required String modelType,
      required String reference,
      String? repReference}) async {
    final bool isSuccess = await addConnectionRequestController.addClubRequest(
        userId, modelType, reference);
    if (isSuccess) {
      //  allPostController.updatePostHide(contentId, true);
      discoverClubController.getDiscoverClub();
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
      {required String contentId, required String status}) async {
    final bool isSuccess = await changeConnectionStatusController
        .changeConnectionStatus(contentId, status);
    if (isSuccess) {
      myJoiningClubController.getJoiningClub('pending');
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            addConnectionRequestController.errorMessage ?? 'Failed', true);
      }
    }
  }
}
