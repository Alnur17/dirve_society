import 'dart:developer';
import 'package:dirve_society/app/modules/profile/views/filter_car_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/all_filter_controller.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(AllFilterController());
    Get.put(FilterController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Filter'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Image.asset(
              AppImages.close,
              scale: 4,
            ),
          ),
        ],
      ),
      body: GetBuilder<AllFilterController>(
        builder: (allFilterController) {
          if (allFilterController.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (allFilterController.errorMessage != null) {
            return Center(
                child: Text('Error: ${allFilterController.errorMessage}'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price Range
                Text(
                  'Price',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Min',
                        borderColor: AppColors.darkRed,
                        onChange: (value) => controller.setMinPrice(value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Max',
                        borderColor: AppColors.darkRed,
                        onChange: (value) => controller.setMaxPrice(value),
                      ),
                    ),
                  ],
                ),
                sh16,
                // Brands
                Text(
                  'Brands',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.brands.isEmpty
                      ? const Text('No brands available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.brands.map((brand) {
                            return GestureDetector(
                              onTap: () => controller.selectBrand(brand),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: controller.selectedBrand.value == brand
                                      ? AppColors.darkRed
                                      : AppColors.silver,
                                ),
                                child: Text(
                                  brand,
                                  style: h6.copyWith(
                                    color:
                                        controller.selectedBrand.value == brand
                                            ? AppColors.white
                                            : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Condition
                Text(
                  'Condition',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.conditions.isEmpty
                      ? const Text('No conditions available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.conditions.map((condition) {
                            return GestureDetector(
                              onTap: () =>
                                  controller.selectCondition(condition),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: controller.selectedCondition.value ==
                                          condition
                                      ? AppColors.darkRed
                                      : AppColors.silver,
                                ),
                                child: Text(
                                  condition,
                                  style: h6.copyWith(
                                    color: controller.selectedCondition.value ==
                                            condition
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Vehicle Type
                // Text(
                //   'Vehicle Type',
                //   style: h4.copyWith(fontWeight: FontWeight.bold),
                // ),
                // sh8,
                // Obx(
                //   () => controller.vehicleTypes.isEmpty
                //       ? const Text('No vehicle types available')
                //       : Wrap(
                //           spacing: 8,
                //           runSpacing: 8,
                //           children: controller.vehicleTypes.map((type) {
                //             return GestureDetector(
                //               onTap: () => controller.selectVehicleType(type),
                //               child: Container(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 12, vertical: 8),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(30),
                //                   color: controller.selectedVehicleType.value == type
                //                       ? AppColors.darkRed
                //                       : AppColors.silver,
                //                 ),
                //                 child: Text(
                //                   type,
                //                   style: h6.copyWith(
                //                     color: controller.selectedVehicleType.value == type
                //                         ? AppColors.white
                //                         : AppColors.black,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //         ),
                // ),

                // Year
                Text(
                  'Year',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.years.isEmpty
                      ? const Text('No years available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.years.map((year) {
                            return GestureDetector(
                              onTap: () => controller.selectYear(year),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: controller.selectedYear.value == year
                                      ? AppColors.darkRed
                                      : AppColors.silver,
                                ),
                                child: Text(
                                  year,
                                  style: h6.copyWith(
                                    color: controller.selectedYear.value == year
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Colours
                Text(
                  'Colours',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.colors.isEmpty
                      ? const Text('No colors available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.colors.map((color) {
                            return GestureDetector(
                              onTap: () => controller.selectColor(color),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: controller.selectedColor.value == color
                                      ? AppColors.darkRed
                                      : AppColors.silver,
                                ),
                                child: Text(
                                  color,
                                  style: h6.copyWith(
                                    color:
                                        controller.selectedColor.value == color
                                            ? AppColors.white
                                            : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Mileage
                Text(
                  'Mileage',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.mileages.isEmpty
                      ? const Text('No mileage options available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.mileages.map((mileage) {
                            return GestureDetector(
                              onTap: () => controller.selectMileage(mileage),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: controller.selectedMileage.value ==
                                          mileage
                                      ? AppColors.darkRed
                                      : AppColors.silver,
                                ),
                                child: Text(
                                  mileage.toString(),
                                  style: h6.copyWith(
                                    color: controller.selectedMileage.value ==
                                            mileage
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Transmission
                Text(
                  'Transmission',
                  style: h4.copyWith(fontWeight: FontWeight.bold),
                ),
                sh8,
                Obx(
                  () => controller.transmissions.isEmpty
                      ? const Text('No transmissions available')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              controller.transmissions.map((transmission) {
                            return GestureDetector(
                              onTap: () =>
                                  controller.selectTransmission(transmission),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:
                                      controller.selectedTransmission.value ==
                                              transmission
                                          ? AppColors.darkRed
                                          : AppColors.silver,
                                ),
                                child: Text(
                                  transmission,
                                  style: h6.copyWith(
                                    color:
                                        controller.selectedTransmission.value ==
                                                transmission
                                            ? AppColors.white
                                            : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                sh16,
                // Stores

                sh16,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.silver)),
          color: AppColors.bottomNavbar,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              width: 80,
              text: 'Reset',
              onPressed: () {
                controller.resetFilters();
                log('Reset tapped');
              },
              borderColor: AppColors.black,
              textStyle: h4.copyWith(fontWeight: FontWeight.bold),
              backgroundColor: AppColors.transparent,
            ),
            sw12,
            CustomButton(
              width: 180,
              text: 'Show results',
              onPressed: () {
                final filters = controller.getSelectedFilters();
                log('Selected Filters: $filters');
                Get.to(() => MyFilterGarageView(data: filters));
              },
              textStyle: h4.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
