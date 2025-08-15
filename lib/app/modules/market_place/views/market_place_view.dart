import 'package:dirve_society/app/modules/home/views/date_formatter.dart';
import 'package:dirve_society/app/modules/market_place/controllers/market_place_controller.dart';
import 'package:dirve_society/app/modules/market_place/views/filter_view.dart';
import 'package:dirve_society/app/modules/market_place/views/listing_details_view.dart';
import 'package:dirve_society/common/app_images/app_images.dart';
import 'package:dirve_society/common/app_text_style/styles.dart';
import 'package:dirve_society/common/widgets/search_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class MarketPlaceView extends StatefulWidget {
  const MarketPlaceView({super.key});

  @override
  State<MarketPlaceView> createState() => _MarketPlaceViewState();
}

class _MarketPlaceViewState extends State<MarketPlaceView> {
  final AllMarketplaceController allMarketplaceController =
      Get.put(AllMarketplaceController());

  @override
  void initState() {
    allMarketplaceController.getAllMarketPlace();
    super.initState();
  }

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
            Row(
              children: [
                Expanded(
                  child: SearchFiled(
                    onChanged: (value) {},
                  ),
                ),
                sw8,
                GestureDetector(
                  onTap: () {
                    Get.to(() => FilterView());
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: AppColors.borderColor,
                      ),
                    ),
                    child: Image.asset(
                      AppImages.filter,
                      scale: 4,
                    ),
                  ),
                )
              ],
            ),
            sh16,
            Expanded(
              child:
                  GetBuilder<AllMarketplaceController>(builder: (controller) {
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16, 
                      mainAxisSpacing: 16,
                      mainAxisExtent: 250),
                  itemCount: controller.allMarketPlaceList?.length,
                  itemBuilder: (context, index) {
                    final dateFormatter = DateFormatter(
                        controller.allMarketPlaceList![index].createdAt ??
                            DateTime.now());
                    return MarketPlaceWidget(
                      name: controller.allMarketPlaceList![index].brand ?? '',
                      price: controller.allMarketPlaceList![index].price
                          .toString(),
                      date: dateFormatter.getRelativeTimeFormat(),
                      imageUrl: controller.allMarketPlaceList![index].images[0],
                      onTap: () {
                        Get.to(() => ListingDetailsView(
                              id: controller.allMarketPlaceList![index].id ??
                                  '',
                            ));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
