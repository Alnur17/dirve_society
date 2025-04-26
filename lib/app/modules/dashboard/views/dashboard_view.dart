import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
            () {
          return controller.currentScreen;
        },
      ),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.bottomNavbar,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            splashColor: AppColors.textColorBlue,
            elevation: 20,
            focusElevation: 20.0,
            backgroundColor: AppColors.black,
            onPressed: () {
              log('search tapped');
              //Get.to(() => const MySearchView());
            },
            shape: const CircleBorder(),
            child: Image.asset(
              AppImages.searchNav,
              scale: 4,
              //color: AppColors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomNavbar extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65,
      color: AppColors.bottomNavbar,
      child: Obx(
            () => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                inactiveIcon: AppImages.home,
                index: 0,
                controller: controller,
                activeIcon: AppImages.homeFilled,
              ),
              _buildNavItem(
                inactiveIcon: AppImages.basket,
                index: 1,
                controller: controller,
                activeIcon: AppImages.basketFilled,
              ),
              SizedBox(
                width: Get.width * 0.08,
              ), // Space for FAB
              _buildNavItem(
                inactiveIcon: AppImages.chat,
                index: 2,
                controller: controller,
                activeIcon: AppImages.chatFilled,
              ),
              _buildNavItem(
                inactiveIcon: AppImages.person,
                index: 3,
                controller: controller,
                activeIcon: AppImages.personFilled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A helper method to build a navigation item with icon and label
  Widget _buildNavItem({
    required String inactiveIcon,
    required String activeIcon,
    required int index,
    required DashboardController controller,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      child: Image.asset(
        isSelected ? activeIcon : inactiveIcon,
        scale: 4,
      ),
    );
  }
}
