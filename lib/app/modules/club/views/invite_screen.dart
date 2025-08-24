import 'package:dirve_society/app/modules/club/controllers/change_admin_controller.dart';
import 'package:dirve_society/app/modules/club/controllers/club_members_controller.dart';
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
  final AllClubMembersController allClubMembersController =
      Get.put(AllClubMembersController());
  final ChangeAdminController changeAdminController =
      Get.put(ChangeAdminController());
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    allClubMembersController.getAllClubMembers(widget.id);
  }

  void _showMenu(
      BuildContext context, Offset buttonPosition, int index, String memberId) {
    const menuWidth = 150.0; // Width of the menu

    // Calculate the left position to place the menu to the left of the button
    double leftPosition = buttonPosition.dx - menuWidth;
    if (leftPosition < 10) {
      leftPosition = 10; // Keep some padding from the left edge
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // GestureDetector to detect taps outside the menu
          GestureDetector(
            onTap: _closeMenu,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Menu container
          Positioned(
            top: buttonPosition.dy,
            left: leftPosition,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: menuWidth,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _menuItem("Remove Member", () {
                      _closeMenu();
                    }),
                    _menuItem("Change to admin", color: Colors.red, () {
                      changeAdmin(memberId);
                      _closeMenu();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isMenuOpen = true;
    });
  }

  // Function to close the dropdown menu
  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isMenuOpen = false;
    });
  }

  // Helper function to create menu items
  Widget _menuItem(String title, VoidCallback onTap, {Color? color}) {
    color ??= AppColors.black;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          title,
          style: h6.copyWith(color: color),
        ),
      ),
    );
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
      ),
      body: GestureDetector(
        onTap: () {
          if (_isMenuOpen) {
            _closeMenu();
          }
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
              GetBuilder<AllClubMembersController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.clubMembersList == null ||
                    controller.clubMembersList!.isEmpty) {
                  return const Center(child: Text('No members found'));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: controller.clubMembersList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final member = controller.clubMembersList![index];
                      // Create a unique GlobalKey for each item
                      final GlobalKey menuButtonKey = GlobalKey();
                      return Card(
                        color: AppColors.mainColor,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: member.user?.photoUrl != null &&
                                    member.user!.photoUrl!.isNotEmpty
                                ? NetworkImage(member.user!.photoUrl!)
                                : const AssetImage(
                                        'assets/images/default_avatar.png')
                                    as ImageProvider, // Fallback image
                          ),
                          title: Text(
                            member.user?.name ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            isAdmin && member.user?.id == widget.authorId
                                ? 'Admin'
                                : 'Member',
                            style: const TextStyle(fontSize: 12),
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

  Future<void> changeAdmin(String userId) async {
    final bool isSuccess =
        await changeAdminController.changeAdmin(widget.id, userId);

    if (isSuccess) {
      if (mounted) {
        allClubMembersController.getAllClubMembers(widget.id);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            changeAdminController.errorMessage ?? 'Failed to update profile',
            true);
      }
    }
  }
}
