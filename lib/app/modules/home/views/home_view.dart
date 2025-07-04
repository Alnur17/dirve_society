import 'package:dirve_society/app/data/dummy_data.dart';
import 'package:dirve_society/app/modules/chat/views/chat_view.dart';
import 'package:dirve_society/app/modules/home/views/connect_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/post_card.dart';
import '../../../../common/helper/story_widget.dart';
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
          child: Obx(
            () => Row(
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
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => controller.isFeedSelected.value
                ? Column(
                    children: [
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
                            child: StoryWidget(
                              image: AppImages.carImage,
                            ),
                          ),
                        ),
                      ),
                      sh12,
                      Expanded(
                        child: ListView.builder(
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
                            onProfileTap: () {},
                            onMenuTap: () {},
                            onLikeTap: () {},
                            onCommentTap: () {},
                            onBookmarkTap: () {},
                          ),
                        ),
                      ),
                    ],
                  )
                : CardSwiper(
                    cardsCount: DummyData.carRatings.length,
                    cardBuilder: (context, index, x, y) {
                      final car = DummyData.carRatings[index];
                      return Card(
                        elevation: 4,
                        //margin: EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                car['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                      AppImages.carImageFive,
                                    ),
                                  ),
                                  sw5,
                                  Expanded(
                                    child: Text(
                                      car['description'],
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.black,
                                            offset: Offset(1, 1),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  sw12,
                                  Image.asset(
                                    AppImages.chatRed,
                                    scale: 4,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSwipe: (previousIndex, currentIndex, direction) {
                      print('Swiped card $previousIndex to $direction');
                      return true;
                    },
                    allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                      horizontal: true,
                    ),
                    padding: EdgeInsets.only(
                      bottom: 35,
                      left: 20,
                      right: 20,
                      top: 8,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
