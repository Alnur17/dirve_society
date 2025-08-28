import 'package:dirve_society/app/modules/club/controllers/add_invite_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/all_invite_people_controller.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:dirve_society/common/widgets/custom_textfield.dart';
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
  String search = '';

  @override
  void initState() {
    super.initState();
    allInvitePeopleController.getInvitePeople(widget.id);
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
                  child: Obx(
                    () => addInviteController.inProgress
                        ? const Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()))
                        : Center(
                            child: Text(
                              'Send Invite',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.borderColor),
                  color: Colors.white,
                ),
                child: TextFormField(
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
              sh16,
              Expanded(
                child: GetBuilder<AllInvitePeopleController>(
                  builder: (controller) {
                    if (controller.inProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Filter members based on search query
                    final filteredMembers =
                        controller.allInvitePeople?.inviteList.where((member) {
                              final name = member.name?.toLowerCase() ?? '';
                              return search.isEmpty ||
                                  name.contains(search.toLowerCase());
                            }).toList() ??
                            [];

                    if (filteredMembers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.search, // Use correct image path
                              height: 80,
                              width: 95,
                            ),
                            Text(
                              'No results for "${search.isEmpty ? 'User' : search}"',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'We couldn’t find any matching results. Please refine your search or check back later.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: filteredMembers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final member = filteredMembers[index];
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
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
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
        ),
      ),
    );
  }
}
