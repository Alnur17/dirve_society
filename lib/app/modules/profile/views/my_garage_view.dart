import 'package:dirve_society/app/data/dummy_data.dart';
import 'package:dirve_society/app/modules/home/views/date_formatter.dart';
import 'package:dirve_society/app/modules/profile/controllers/my_garage_controller.dart';
import 'package:dirve_society/app/modules/profile/views/add_car_view.dart';
import 'package:dirve_society/common/widgets/custom_button.dart';
import 'package:dirve_society/get_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../market_place/views/listing_details_view.dart';

class MyGarageView extends StatefulWidget {
  const MyGarageView({super.key});

  @override
  State<MyGarageView> createState() => _MyGarageViewState();
}

class _MyGarageViewState extends State<MyGarageView> {
  final MyGarageController myGarageController = Get.put(MyGarageController());

  @override
  void initState() {
    myGarageController.getMyGarage();
    super.initState();
  }

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
              Positioned(
                bottom: -25,
                left: 20,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage(AppImages.carImageFive),
                ),
              ),
              Positioned(
                right: 20,
                left: Get.width * 0.32,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StorageUtil.getData(StorageUtil.profileName) ?? '',
                      style: h1.copyWith(
                        fontSize: 20,
                        color: AppColors.darkRed,
                      ),
                    ),
                    sw8,
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 22,
                          color: AppColors.darkRed,
                        ),
                        sw5,
                        Text(
                          StorageUtil.getData(StorageUtil.profileAvgRating)
                              .toString(),
                          style: h3.copyWith(
                            color: AppColors.darkRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          sh40,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Descriptions',
                      style: h5.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  ],
                ),
                sh5,
                ReadMoreText(
                  StorageUtil.getData(StorageUtil.profileBio) ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: ' Show Less',
                  style: h6,
                  moreStyle: h6.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  lessStyle: h6.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          sh20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Garage',
                  style: h1.copyWith(fontSize: 20),
                ),
                CustomButton(
                  height: 38,
                  width: 135,
                  text: 'Add Car',
                  imageAssetPath: AppImages.add,
                  iconColor: AppColors.white,
                  onPressed: () {
                    Get.to(() => AddCarView());
                  },
                ),
              ],
            ),
          ),
          GetBuilder<MyGarageController>(builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.myGarageList?.length,
                    itemBuilder: (context, index) {
                      final dateFormatter = DateFormatter(
                          controller.myGarageList?[index].createdAt ??
                              DateTime.now());
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 12 : 8,
                          bottom: index == DummyData.cars.length - 1 ? 20 : 0,
                        ),
                        child: MarketPlaceWidget(
                          height: 200,
                          name: controller.myGarageList?[index].brand ?? '',
                          price: controller.myGarageList?[index].price
                                  .toString() ??
                              '',
                          date: dateFormatter.getFullDateFormat(),
                          imageUrl:
                              controller.myGarageList?[index].images[0] ?? '',
                          onTap: () {
                            Get.to(() => ListingDetailsView(
                                  id: controller.myGarageList?[index].id ?? '',
                                ));
                          },
                        ),
                      );
                    }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
