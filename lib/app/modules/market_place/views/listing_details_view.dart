import 'package:dirve_society/app/data/dummy_data.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/helper/info_container.dart';
import 'package:dirve_society/common/widgets/custom_row_header.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/helper/review_card.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';

class ListingDetailsView extends GetView {
  const ListingDetailsView({super.key});

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
        title: Text(
          'Listing Details',
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.silver,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppImages.carImageFour,
                  scale: 4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 8,
                    right: index == 5 - 1 ? 20 : 0,
                  ),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.silver,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        AppImages.carImageFour,
                        scale: 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            sh20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nissan R35 GTR',
                        style: h1.copyWith(fontSize: 20),
                      ),
                      Text(
                        '£500,000',
                        style: h1.copyWith(
                          fontSize: 20,
                          color: AppColors.darkRed,
                        ),
                      ),
                    ],
                  ),
                  sh8,
                  Text(
                    'Duis vitae egestas sapien. Quisque ornare eleifend augue in dignissim.',
                    style: h6,
                  ),
                  sh20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoContainer(
                          imagePath: AppImages.transmission,
                          label: 'Transmission',
                          value: '5403 Mi'),
                      InfoContainer(
                          imagePath: AppImages.mileage,
                          label: 'Mileage',
                          value: 'Manual'),
                      InfoContainer(
                          imagePath: AppImages.fuel,
                          label: 'Fuel',
                          value: 'Petrol'),
                    ],
                  ),
                  sh20,
                  Text(
                    'Seller Details',
                    style: h3,
                  ),
                  sh12,
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.silver),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              AppImages.carImageFive,
                              scale: 4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        sw8,
                        Column(
                          children: [
                            Text(
                              'Richard Abhiana',
                              style: h3.copyWith(fontSize: 14),
                            ),
                            sh8,
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.stars,
                                  scale: 4,
                                ),
                                sw8,
                                Text('4.7 (25)', style: h7),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          AppImages.chatRed,
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sh20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews',
                        style: h3,
                      ),
                      sh5,
                      Row(
                        children: [
                          Image.asset(
                            AppImages.stars,
                            scale: 4,
                          ),
                          sw8,
                          Text('4.7 (25)', style: h7),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Show All',
                        style: h6.copyWith(color: AppColors.darkRed),
                      ),
                      sw8,
                      Image.asset(
                        AppImages.arrowRight,
                        scale: 4,
                        color: AppColors.darkRed,
                      )
                    ],
                  )
                ],
              ),
            ),
            sh12,
            SizedBox(
              height: 170, // Fixed height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: DummyData.reviews.length,
                itemBuilder: (context, index) {
                  final review = DummyData.reviews[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 20 : 8,
                      right: index == DummyData.reviews.length - 1 ? 20 : 0,
                    ),
                    child: ReviewCard(
                      rating: review['rating'],
                      reviewText: review['reviewText'],
                      reviewerName: review['reviewerName'],
                      date: review['date'],
                      imagePath: AppImages.carImageFive,
                    ),
                  );
                },
              ),
            ),
            sh20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomRowHeader(
                title: 'More From This Seller',
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                //padding: EdgeInsets.only(bottom: 20),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: DummyData.cars.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 12,
                      left: index == 0 ? 20 : 8,
                      right: index == DummyData.cars.length - 1 ? 20 : 0,
                      bottom: 20,
                    ),
                    child: MarketPlaceWidget(
                      name: DummyData.cars[index]['name']!,
                      price: DummyData.cars[index]['price']!,
                      date: DummyData.cars[index]['date']!,
                      imageUrl: DummyData.cars[index]['image']!,
                      onTap: () {
                        Get.to(() => ListingDetailsView());
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
