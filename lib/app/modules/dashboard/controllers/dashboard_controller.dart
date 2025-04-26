import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../home/views/home_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> _screens = [
    const HomeView(),
     Container(color: AppColors.red,),
     Container(color: AppColors.green,),
     Container(color: AppColors.blue,),
  ];

  Widget get currentScreen => _screens[selectedIndex.value];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
