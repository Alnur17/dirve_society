import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/widgets/search_filed.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/market_place_controller.dart';

class MarketPlaceView extends GetView<MarketPlaceController> {
  MarketPlaceView({super.key});

  final List<Map<String, String>> cars = [
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageFive
    },
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageThree
    },
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageTwo
    },
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageFour
    },
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageFour
    },
    {
      'name': 'Nissan R35 GTR',
      'price': '£500,000',
      'date': 'April 4',
      'image': AppImages.carImageFour
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Marketplace',
          style: appBarStyle.copyWith(color: AppColors.darkRed),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchFiled(
              onChanged: (value) {},

            ),
            sh16,
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 250
                ),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return CarCard(
                    name: cars[index]['name']!,
                    price: cars[index]['price']!,
                    date: cars[index]['date']!,
                    imageUrl: cars[index]['image']!,
                    onTap: () {
                      print('object');
                    },
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

class CarCard extends StatelessWidget {
  final String name;
  final String price;
  final String date;
  final String imageUrl;
  final VoidCallback onTap;

  const CarCard({
    super.key,
    required this.name,
    required this.price,
    required this.date,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Text content overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
