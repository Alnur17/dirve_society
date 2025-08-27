import 'package:dirve_society/app/modules/club/controllers/add_invite_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/all_invite_people_controller.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/common/widgets/search_filed.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteScreen extends StatefulWidget {
  final String authorId;
  final String id;
  const InviteScreen({super.key, required this.id, required this.authorId});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  final AllInvitePeopleController allInvitePeopleController =
      Get.put(AllInvitePeopleController());
  final AddInviteController addInviteController =
      Get.put(AddInviteController());

  List<String> inviteList = []; // Store selected member IDs

  @override
  void initState() {
    super.initState();
    allInvitePeopleController.getInvitePeople(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin =
        widget.authorId == StorageUtil.getData(StorageUtil.profileId);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Members',
          style: appBarStyle.copyWith(color: AppColors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          if (isAdmin)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 32,
                width: 90,
                child: GestureDetector(
                  onTap: () {
                    if (inviteList.isNotEmpty) {
                      print('Selected members: $inviteList');
                      addInvite();
                    }
                  },
                  child: Center(
                    child: Text(
                      'Send Invite',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SearchFiled(
                onChanged: (value) {
                  // Implement search logic if needed
                },
              ),
              sh16,
              GetBuilder<AllInvitePeopleController>(builder: (controller) {
                if (controller.inProgress) {
                  return SizedBox(
                      height: 600,
                      child: const Center(child: CircularProgressIndicator()));
                }
                if (controller.allInvitePeople == null ||
                    controller.allInvitePeople!.inviteList.isEmpty) {
                  return SizedBox(
                      height: 600,
                      child: const Center(child: Text('No members found')));
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: controller.allInvitePeople!.inviteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final member =
                          controller.allInvitePeople!.inviteList[index];
                      return widget.authorId == member.id
                          ? Container()
                          : Card(
                              color: AppColors.mainColor,
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: inviteList.contains(member.id),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            inviteList.add(member.id ?? '');
                                          } else {
                                            inviteList.remove(member.id);
                                          }
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: member.photoUrl !=
                                                      null &&
                                                  member.photoUrl!.isNotEmpty
                                              ? NetworkImage(member.photoUrl!)
                                              : const AssetImage(
                                                  'assets/images/default_avatar.png'),
                                        ),
                                        title: Text(
                                          member.name ?? 'Unknown',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                          isAdmin &&
                                                  member.id == widget.authorId
                                              ? 'Admin'
                                              : 'Member',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addInvite() async {
    final bool isSuccess = await addInviteController.addInvite(
      widget.id,
      inviteList,
    );

    if (isSuccess) {
      if (mounted) {
        allInvitePeopleController.getInvitePeople(widget.id);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            addInviteController.errorMessage ?? 'Failed to update profile',
            true);
      }
    }
  }
}
