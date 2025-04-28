import 'package:dirve_society/app/data/dummy_data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../market_place/views/listing_details_view.dart';

class MyGarageView extends GetView {
  const MyGarageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColors.black.withOpacity(0.3),
                      ),
                      child: Image.asset(
                        AppImages.back,
                        scale: 4,
                      )),
                ),
              ),
              // Positioned(
              //   right: 20,
              //   top: 40,
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: ShapeDecoration(
              //         shape: CircleBorder(),
              //         color: AppColors.black.withOpacity(0.3),
              //       ),
              //       child: Image.asset(
              //         AppImages.menu,
              //         scale: 4,
              //         color: AppColors.white,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: -50,
                left: 20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                right: 20,
                left: Get.width * 0.365,
                bottom: -80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nissan R35 GTR',
                      style: h1.copyWith(
                        fontSize: 20,
                        color: AppColors.darkRed,
                      ),
                    ),
                    sh5,
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: AppColors.darkRed,
                        ),
                        sw5,
                        Text(
                          '4.7',
                          style: h6,
                        ),
                      ],
                    ),
                    sh5,
                    Text(
                      '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                      style: h6,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                    // ReadMoreText(
                    //   '5.0L V8 • 460HP • Custom Exhaust Clean, powerful, and ready to roar. Only 38k miles. DM to take it for a spin!',
                    //   trimLines: 2,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: 'Show More',
                    //   trimExpandedText: ' Show Less',
                    //   style: h6,
                    //   moreStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   lessStyle: h6.copyWith(
                    //     color: AppColors.grey,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: -60,
                right: Get.width * 0.67,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange[600],
                  ),
                  child: Center(
                    child: Text(
                      '190 Points',
                      style: h6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          sh87,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Garage',
              style: h1.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: DummyData.cars.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? 12 : 8,
                    bottom: index == DummyData.cars.length - 1 ? 20 : 0,
                  ),
                  child: MarketPlaceWidget(
                    height: 200,
                    name: DummyData.cars[index]['name']!,
                    price: DummyData.cars[index]['price']!,
                    date: DummyData.cars[index]['date']!,
                    imageUrl: DummyData.cars[index]['image']!,
                    onTap: () {
                      Get.to(() => ListingDetailsView());
                    },
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
