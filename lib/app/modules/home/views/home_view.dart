import 'package:dirve_society/app/modules/chat/views/chat_view.dart';
import 'package:dirve_society/app/modules/home/views/connect_view.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.white,
            backgroundImage: AssetImage(AppImages.carImage),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ConnectView());
            },
            child: Image.asset(
              AppImages.addGroup,
              scale: 4,
            ),
          ),
          sw12,
          GestureDetector(
            onTap: () {
              //Get.to(() => SearchView());
            },
            child: Image.asset(
              AppImages.search,
              scale: 4,
            ),
          ),
          sw12,
          GestureDetector(
            onTap: () {
              Get.to(() => ChatView());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.silver)),
              child: Image.asset(
                AppImages.chatTwo,
                scale: 4,
              ),
            ),
          ),
          sw20,
        ],
      ),
      body: TabbedFeed(),
    );
  }
}

class TabbedFeed extends GetView<HomeController> {
  const TabbedFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Obx(() => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.isFeedSelected.value = true;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: controller.isFeedSelected.value
                              ? Colors.red
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Text(
                            'FEED',
                            style: TextStyle(
                              color: controller.isFeedSelected.value
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sw8,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.isFeedSelected.value = false;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: controller.isFeedSelected.value
                              ? AppColors.white
                              : Colors.red,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Text(
                            'Car Rating',
                            style: TextStyle(
                              color: controller.isFeedSelected.value
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        // Horizontal List of Cars
        SizedBox(
          height: 80.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 20 : 0,
                right: index == 10 - 1 ? 20 : 8,
              ),
              child: CarCircle(
                image: AppImages.carImage,
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() => controller.isFeedSelected.value
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 30),
                  itemCount: 10,
                  itemBuilder: (context, index) => PostCard(
                    clubName: 'MC20 Owners CLUB',
                    userName: 'John Doe',
                    postImages: [
                      AppImages.carImage,
                      AppImages.carImageThree,
                      AppImages.carImageTwo,
                    ],
                    description:
                        'Nam posuere elit a facilisis hendrerit. Phasellus cursus nisi vel tempor gravida. Vivamus sollicitudin a nisi eu aliquam aliqu...',
                    hashtags: '#Blessed #MC20',
                    date: 'April 4',
                    likes: 100,
                    comments: 100,
                    menuTap: () {},
                  ),
                )
              : Center(
                  child: Text(
                    'Car Rating View',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                  ),
                )),
        ),
      ],
    );
  }
}

class CarCircle extends StatelessWidget {
  final String image;

  const CarCircle({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: AssetImage(image),
    );
  }
}

class PostCard extends StatelessWidget {
  final String clubName;
  final String userName;
  final List<String> postImages;
  final String description;
  final String hashtags;
  final String date;
  final int likes;
  final int comments;
  final VoidCallback menuTap;

  const PostCard({
    super.key,
    required this.clubName,
    required this.userName,
    required this.postImages,
    required this.description,
    required this.hashtags,
    required this.date,
    required this.likes,
    required this.comments,
    required this.menuTap,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(AppImages.carImage),
                ),
                sw8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clubName,
                      style: h5.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'BY $userName'.toUpperCase(),
                      style: h7,
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: menuTap,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.silver,
                    ),
                    child: Image.asset(
                      AppImages.menu,
                      scale: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: postImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(postImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2),
                ),
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: postImages.length,
                  effect: WormEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    activeDotColor: AppColors.white,
                    dotColor: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
          // Post Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
            child: Row(
              children: [
                Icon(Icons.favorite, color: Colors.red),
                sw5,
                Text(
                  likes.toString(),
                  style: TextStyle(color: AppColors.black),
                ),
                sw16,
                Icon(Icons.comment, color: AppColors.grey),
                sw5,
                Text(
                  comments.toString(),
                  style: TextStyle(color: AppColors.black),
                ),
                Spacer(),
                Icon(Icons.bookmark_border, color: AppColors.grey),
              ],
            ),
          ),
          // Post Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$userName ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: TextStyle(color: AppColors.black),
                  ),
                  TextSpan(
                    text: hashtags,
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          // Post Date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
            child: Text(
              date,
              style: TextStyle(color: AppColors.grey, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
