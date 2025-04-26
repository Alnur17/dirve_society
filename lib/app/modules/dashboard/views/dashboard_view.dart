import 'package:dirve_society/app/modules/market_place/views/market_place_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../home/views/home_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    Container(
      color: AppColors.red,
    ),
    MarketPlaceView(),
    Container(
      color: AppColors.blue,
    ),
  ];

  void _changeTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            padding: EdgeInsets.zero,
            height: 80,
            color: AppColors.bottomNavbar,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _changeTabIndex(0),
                    child: NavBarItem(
                      selectedIcon: AppImages.homeRed,
                      unselectedIcon: AppImages.home,
                      label: "Home",
                      isSelected: _selectedIndex == 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTabIndex(1),
                    child: NavBarItem(
                      selectedIcon: AppImages.locationRed,
                      unselectedIcon: AppImages.location,
                      label: "   Meets   ",
                      isSelected: _selectedIndex == 1,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.10),
                  GestureDetector(
                    onTap: () => _changeTabIndex(2),
                    child: NavBarItem(
                      selectedIcon: AppImages.marketPlaceRed,
                      unselectedIcon: AppImages.marketPlace,
                      label: "Market Place",
                      isSelected: _selectedIndex == 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTabIndex(3),
                    child: NavBarItem(
                      selectedIcon: AppImages.personRed,
                      unselectedIcon: AppImages.person,
                      label: "Profile",
                      isSelected: _selectedIndex == 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: Get.width * 0.4,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.bottomNavbar,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  splashColor: Colors.red[50],
                  backgroundColor: AppColors.transparent,
                  onPressed: () {
                    // Get.to(() => UploadPostView());
                  },
                  shape: const CircleBorder(),
                  elevation: 0,
                  child: Image.asset(
                    AppImages.steeringWheel,
                    scale: 4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;

  const NavBarItem({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
          scale: 4,
        ),
        sh5,
        Center(
          child: Text(
            label,
            style: h5.copyWith(
              color: isSelected ? AppColors.darkRed : AppColors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
