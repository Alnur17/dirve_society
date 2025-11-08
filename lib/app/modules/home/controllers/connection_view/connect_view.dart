import 'package:dirve_society/app/modules/home/views/all_people_screen.dart';
import 'package:dirve_society/app/modules/home/views/connect_group_view.dart';
import 'package:dirve_society/app/modules/home/views/connect_user_view.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import 'connect_controller.dart';

class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  @override
  State<ConnectView> createState() => _ConnectViewState();
} 

class _ConnectViewState extends State<ConnectView> {
  final ConnectController controller = Get.put(ConnectController());
  int selectedIndex = 0;

  // Initialize buttonStates dynamically based on data length
  late List<bool> buttonStates;

  @override
  void initState() {
    super.initState();
    // Initialize with a default size, will be updated when data is loaded
    buttonStates = List.generate(6, (_) => false);
  }

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
        actions: [IconButton(onPressed:() {
          Get.to(AllPeopleScreen());
        } , icon: const Icon(Icons.search, size: 26,))],
        title: const Text('Connect'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.silver,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? AppColors.darkRed
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Users',
                          style: TextStyle(
                            color: selectedIndex == 0
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? AppColors.darkRed
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Groups',
                          style: TextStyle(
                            color: selectedIndex == 1
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: selectedIndex == 0
                ? const ConnectUserView()
                : const ConnectGroupView(),
          ),
        ],
      ),
    );                 
  }
}
