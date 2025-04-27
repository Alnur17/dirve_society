import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
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
                        return CarCard(
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

// Reusable CarCard widget (for Users tab)
class CarCard extends StatelessWidget {
  final String title;
  final double rating;
  final String description;
  final bool isAdded;
  final VoidCallback onButtonPressed;

  const CarCard({
    super.key,
    required this.title,
    required this.rating,
    required this.description,
    required this.isAdded,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(AppImages.carImage),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: h1.copyWith(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColors.darkRed,
              ),
              sw5,
              Text(
                rating.toString(),
                style: h3,
              ),
            ],
          ),
          sh5,
          Text(
            description,
            style: h6.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          sh12,
          CustomButton(
            height: 32,
            text: isAdded ? 'Remove' : '+ Add',
            onPressed: onButtonPressed,
            backgroundColor: isAdded ? AppColors.grey : AppColors.darkRed,
          ),
        ],
      ),
    );
  }
}

// Reusable GroupCard widget (for Groups tab)
class GroupCard extends StatelessWidget {
  final String title;
  final String memberCount;
  final bool isPublic;
  final bool isJoined;
  final VoidCallback onJoinPressed;

  const GroupCard({
    super.key,
    required this.title,
    required this.memberCount,
    required this.isPublic,
    required this.isJoined,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Group image placeholder
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(AppImages.carImageFive),
          ),
          SizedBox(height: 10),
          // Title
          Text(
            title,
            style: h1.copyWith(fontSize: 20),
          ),
          SizedBox(height: 5),
          // Member count
          Row(
            children: [
              Image.asset(
                AppImages.groupLight,
                scale: 4,
              ),
              Text(
                memberCount,
                style: h6.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          // Public/Private status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   isPublic ? Icons.lock_open : Icons.lock,
              //   size: 16,
              //   color: AppColors.grey,
              // ),
              Image.asset(
                AppImages.public,
                scale: 4,
              ),
              SizedBox(width: 4),
              Text(
                isPublic ? 'Public Club' : 'Private Club',
                style: h6.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Switchable Join Button
          CustomButton(
            height: 32,
            text: isJoined ? 'Joined' : 'Join',
            onPressed: onJoinPressed,
            backgroundColor: isJoined ? AppColors.grey : AppColors.darkRed,
          ),
        ],
      ),
    );
  }
}
