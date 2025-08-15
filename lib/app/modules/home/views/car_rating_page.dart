// ignore_for_file: avoid_print

import 'package:dirve_society/app/modules/home/controllers/all_car_rating_controller.dart';
import 'package:dirve_society/common/app_color/app_colors.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/size_box/custom_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CarRatingPage extends StatefulWidget {
  const CarRatingPage({super.key});

  @override
  State<CarRatingPage> createState() => _CarRatingPageState();
}

class _CarRatingPageState extends State<CarRatingPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCarRatingController>(builder: (controller) {
      if (controller.inProgress) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (controller.carRatingList == null || controller.carRatingList!.isEmpty) {
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
                  child: Image.network(
                    car.banner ?? AppImages.carImage, // Use network image if available
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImages.carImage, // Fallback image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
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
                        backgroundImage: car.author?.photoUrl != null
                            ? NetworkImage(car.author!.photoUrl!)
                            : const AssetImage(AppImages.carImageFive),
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
        allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
        padding: const EdgeInsets.only(bottom: 35, left: 20, right: 20, top: 8),
      );
    });
  }
}