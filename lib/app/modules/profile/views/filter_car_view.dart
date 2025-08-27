import 'package:dirve_society/app/modules/home/views/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/market_place_widget.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../market_place/views/listing_details_view.dart';
import '../controllers/my_garage_controller.dart';

class MyFilterGarageView extends StatefulWidget {
  final Map<String, dynamic> data;

  const MyFilterGarageView({super.key, required this.data});

  @override
  State<MyFilterGarageView> createState() => _MyFilterGarageViewState();
}

class _MyFilterGarageViewState extends State<MyFilterGarageView> {
  final MyGarageController myGarageController = Get.put(MyGarageController());

  @override
  void initState() {
    super.initState();
    // Pass the filter data directly
    myGarageController.getMyGarage(queryParamsData: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Garage',
              style: h1.copyWith(fontSize: 20),
            ),
          ),
          GetBuilder<MyGarageController>(builder: (controller) {
            if (controller.inProgress) {
              return SizedBox(
                  height: 700,
                  child: const Center(child: CircularProgressIndicator()));
            }
            if (controller.errorMessage != null) {
              return Center(
                child: Text(
                  controller.errorMessage!,
                  style: h4.copyWith(color: AppColors.red),
                ),
              );
            }
            if (controller.myGarageList == null ||
                controller.myGarageList!.isEmpty) {
              return SizedBox(
                  height: 700,
                  child: const Center(child: Text('No results found')));
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.myGarageList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final dateFormatter = DateFormatter(
                      controller.myGarageList![index].createdAt ??
                          DateTime.now(),
                    );
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 12 : 8,
                        bottom: index == controller.myGarageList!.length - 1
                            ? 20
                            : 0,
                      ),
                      child: MarketPlaceWidget(
                        height: 200,
                        name: controller.myGarageList![index].brand ?? '',
                        price: controller.myGarageList![index].price.toString(),
                        date: dateFormatter.getFullDateFormat(),
                        imageUrl:
                            controller.myGarageList![index].images.isNotEmpty
                                ? controller.myGarageList![index].images[0]
                                : '',
                        onTap: () {
                          Get.to(() => ListingDetailsView(
                                id: controller.myGarageList![index].id ?? '',
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
