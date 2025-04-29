import 'package:dirve_society/app/modules/profile/views/profile_view_mode_view.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper/group_card.dart';
import '../../../../common/helper/user_card.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../controllers/connect_controller.dart';

class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  List<bool> buttonStates = List.generate(6, (_) => false);
  final ConnectController controller = Get.put(ConnectController());

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
        title: Text('Connect'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.silver,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => _buildTabButton(
                      'Users',
                      controller.isUsersSelected.value,
                      controller.toggleTab,
                    )),
                Obx(() => _buildTabButton(
                      'Groups',
                      !controller.isUsersSelected.value,
                      controller.toggleTab,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              // Switch between Users and Groups content based on tab selection
              return controller.isUsersSelected.value
                  ? GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 250,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return UserCard(
                          title: 'SUPER CAR',
                          rating: 4.7,
                          description:
                              'Duis vitae egestas sapien. Quisque onaaque in',
                          isAdded: buttonStates[index],
                          onButtonPressed: () {
                            setState(() {
                              buttonStates[index] = !buttonStates[index];
                            });
                          },
                          onUserDetails: (){
                            Get.to(()=> ProfileViewModeView());
                          },
                        );
                      },
                    )
                  : GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 235, // Adjusted for new card height
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GroupCard(
                          title: 'SUPER CAR',
                          memberCount: '10.1K Members',
                          isPublic: true,
                          isJoined: buttonStates[index],
                          onJoinPressed: () {
                            setState(() {
                              buttonStates[index] = !buttonStates[index];
                            });
                          },
                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkRed : AppColors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
