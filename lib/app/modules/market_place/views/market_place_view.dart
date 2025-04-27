import 'package:dirve_society/app/data/dummy_data.dart';
import 'package:dirve_society/app/modules/market_place/views/listing_details_view.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/widgets/search_filed.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/market_place_controller.dart';

class MarketPlaceView extends GetView<MarketPlaceController> {
  const MarketPlaceView({super.key});

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
                itemCount: DummyData.cars.length,
                itemBuilder: (context, index) {
                  return MarketPlaceWidget(
                    name: DummyData.cars[index]['name']!,
                    price: DummyData.cars[index]['price']!,
                    date: DummyData.cars[index]['date']!,
                    imageUrl: DummyData.cars[index]['image']!,
                    onTap: () {
                      Get.to(()=> ListingDetailsView());
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

