// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/chat/views/chat_view.dart';
import 'package:dirve_society/app/modules/home/controllers/all_car_rating_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/all_feed_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/dis_react_controller.dart';
import 'package:dirve_society/app/modules/home/controllers/react_controller.dart';
import 'package:dirve_society/app/modules/home/views/connect_view.dart';
import 'package:dirve_society/app/modules/home/views/date_formatter.dart';
import 'package:dirve_society/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/post_card.dart';
import '../../../../common/helper/story_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AllFeedController allFeedController = Get.put(AllFeedController());
  final AllCarRatingController allCarRatingController =
      Get.put(AllCarRatingController());

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMoreData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allFeedController.getAllFeed();
      allCarRatingController.getAllCarRating();
    });
  }

  void _loadMoreData() {
    if (scrollController.position.extentAfter < 500 &&
        !allFeedController.inProgress) {
      print('Load more data');
      allFeedController.getAllFeed(); 
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
            backgroundImage: const AssetImage(AppImages.carImage),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const ConnectView());
            },
            child: Image.asset(
              AppImages.addGroup,
              scale: 4,
            ),
          ),
          sw12,
          GestureDetector(
            onTap: () {
              Get.to(() => const ChatView());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.silver),
              ),
              child: Image.asset(
                AppImages.chatTwo,
                scale: 4,
              ),
            ),
          ),
          sw20,
        ],
      ),
      body: TabbedFeed(scrollController: scrollController),
    );
  }
}

class TabbedFeed extends StatefulWidget {
  final ScrollController scrollController;

  TabbedFeed({super.key, required this.scrollController});

  @override
  State<TabbedFeed> createState() => _TabbedFeedState();
}

class _TabbedFeedState extends State<TabbedFeed> {
  final ReactPostController reactPostController =
      Get.put(ReactPostController());
  final DisReactPostController disReactPostController =
      Get.put(DisReactPostController());
  // final SavePostController savePostController = Get.put(SavePostController());
  // final UnSavePostController unSavePostController =
  //     Get.put(UnSavePostController());
  final AllFeedController allFeedController = Get.find<AllFeedController>();
  final AllCarRatingController allCarRatingController =
      Get.put(AllCarRatingController());

  Future<void> reactPost(String postId) async {
    final bool isSuccess = await reactPostController.reactPost(postId);
    if (isSuccess) {
      int index =
          allFeedController.postList.indexWhere((post) => post.id == postId);
      if (index != -1) {
        int currentLikes =
            allFeedController.postList[index].contentMeta?.like ?? 0;
        allFeedController.updatePostLike(postId, true, currentLikes + 1);
        if (mounted) {
          showSnackBarMessage(context, 'লাইক সফলভাবে সম্পন্ন হয়েছে');
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            reactPostController.errorMessage ?? 'লাইক করতে ব্যর্থ', true);
      }
    }
  }

  Future<void> disReactPost(String postId) async {
    final bool isSuccess = await disReactPostController.disReactPost(postId);
    if (isSuccess) {
      int index =
          allFeedController.postList.indexWhere((post) => post.id == postId);
      if (index != -1) {
        int currentLikes =
            allFeedController.postList[index].contentMeta?.like ?? 0;
        allFeedController.updatePostLike(
            postId, false, currentLikes > 0 ? currentLikes - 1 : 0);
        if (mounted) {
          showSnackBarMessage(context, 'লাইক মুছে ফেলা হয়েছে');
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            disReactPostController.errorMessage ?? 'লাইক মুছতে ব্যর্থ', true);
      }
    }
  }

  // Future<void> savePost(String userId, String modelType, String contentId) async {
  //   final bool isSuccess =
  //       await savePostController.savePostF(userId, modelType, contentId);
  //   if (isSuccess) {
  //     allFeedController.updatePostSave(contentId, true);
  //     if (mounted) {
  //       showSnackBarMessage(context, 'পোস্ট সফলভাবে সেভ করা হয়েছে');
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           savePostController.errorMessage ?? 'পোস্ট সেভ করতে ব্যর্থ', true);
  //     }
  //   }
  // }

  // Future<void> unSavePost(String postId) async {
  //   final bool isSuccess = await unSavePostController.unSavePost(postId: postId);
  //   if (isSuccess) {
  //     allFeedController.updatePostUnSave(postId, false);
  //     if (mounted) {
  //       showSnackBarMessage(context, 'পোস্ট আনসেভ করা হয়েছে');
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context,
  //           unSavePostController.errorMessage ?? 'পোস্ট আনসেভ করতে ব্যর্থ', true);
  //     }
  //   }
  // }

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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      Obx(() {
                        if (allFeedController.inProgress &&
                            allFeedController.page == 1) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (allFeedController.postList.isEmpty) {
                          return const Center(
                            child: Text(
                              'No posts available',
                              style: TextStyle(color: AppColors.white),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            controller: widget.scrollController,
                            padding: const EdgeInsets.only(bottom: 30),
                            itemCount: allFeedController.postList.length,
                            itemBuilder: (context, index) {
                              final feed = allFeedController.postList[index];
                              final dateFormatter = DateFormatter(
                                  feed.createdAt ?? DateTime.now());
                              return feed.isHide == false
                                  ? PostCard(
                                      clubName: feed.club ?? '',
                                      userName: feed.author?.name ?? 'Unknown',
                                      postImages: feed.content.isNotEmpty
                                          ? feed.content
                                          : [
                                              AppImages.carImage,
                                              AppImages.carImageThree,
                                              AppImages.carImageTwo,
                                            ],
                                      description: feed.description ?? '',
                                      hashtags: feed.tags.isNotEmpty
                                          ? feed.tags[0]
                                          : '',
                                      date:
                                          dateFormatter.getRelativeTimeFormat(),
                                      likes: feed.contentMeta?.like ?? 0,
                                      comments: feed.contentMeta?.comment ?? 0,
                                      onProfileTap: () {
                                        // Navigate to profile (implement as needed)
                                      },
                                      onMenuTap: () {
                                        // Implement menu/bottom sheet as needed
                                      },
                                      onLikeTap: () {
                                        if (feed.isLiked == true) {
                                          disReactPost(
                                              feed.contentMeta?.id ?? '');
                                        } else {
                                          reactPost(feed.contentMeta?.id ?? '');
                                        }
                                      },
                                      onCommentTap: () {
                                        // Navigate to comment screen (implement as needed)
                                      },
                                      onBookmarkTap: () {
                                        // if (feed.isFavorite == true) {
                                        //   unSavePost(feed.id ?? '');
                                        // } else {
                                        //   savePost(
                                        //     StorageUtil.getData(
                                        //             StorageUtil.userId) ??
                                        //         '',
                                        //     'feed', // Adjust modelType as needed
                                        //     feed.id ?? '',
                                        //   );
                                        // }
                                      },
                                    )
                                  : Container();
                            },
                          ),
                        );
                      }),
                    ],
                  )
                : GetBuilder<AllCarRatingController>(builder: (controller) {
                    if (controller.inProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (controller.carRatingList == null ||
                        controller.carRatingList!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No car ratings available',
                          style: TextStyle(color: AppColors.white),
                        ),
                      );
                    }
                    return CardSwiper(
                      cardsCount: controller.carRatingList!.length,
                      cardBuilder: (context, index, x, y) {
                        final car = controller.carRatingList![index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  AppImages.carImage, // Fallback image
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
                                      backgroundImage: const AssetImage(
                                          AppImages.carImageFive),
                                    ),
                                    sw5,
                                    Expanded(
                                      child: Text(
                                        car.author?.name ?? 'Unknown',
                                        style: const TextStyle(
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
                                    ),
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
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                              horizontal: true),
                      padding: const EdgeInsets.only(
                          bottom: 35, left: 20, right: 20, top: 8),
                    );
                  }),
          ),
        ),
      ],
    );
  }
}
