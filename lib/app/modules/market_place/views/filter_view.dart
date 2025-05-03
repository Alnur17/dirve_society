import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  @override
  final FilterController controller = Get.put(FilterController());

  FilterView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Max',
                    borderColor: AppColors.darkRed,
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
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.brands.map((brand) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleBrandSelection(brand);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedBrands.contains(brand)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        brand,
                        style: h6.copyWith(
                          color: controller.selectedBrands.contains(brand)
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
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['New', 'Used'].map((condition) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleConditionSelection(condition);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedConditions.contains(condition)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        condition,
                        style: h6.copyWith(
                          color: controller.selectedConditions.contains(condition)
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
            Text(
              'Vehicle Type',
              style: h4.copyWith(fontWeight: FontWeight.bold),
            ),
            sh8,
            Obx(
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['SUV', 'Sedan', 'Coupe', 'Hatchback', 'Van'].map((type) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleVehicleTypeSelection(type);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedVehicleTypes.contains(type)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        type,
                        style: h6.copyWith(
                          color: controller.selectedVehicleTypes.contains(type)
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
            // Year
            Text(
              'Year',
              style: h4.copyWith(fontWeight: FontWeight.bold),
            ),
            sh8,
            Obx(
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018].map((year) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleYearSelection(year);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedYears.contains(year)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        year.toString(),
                        style: h6.copyWith(
                          color: controller.selectedYears.contains(year)
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
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Black', 'White', 'Red'].map((color) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleColorSelection(color);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedColors.contains(color)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        color,
                        style: h6.copyWith(
                          color: controller.selectedColors.contains(color)
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
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['<10,000 miles', '20,000 miles', '30,000 miles', '40,000 miles>'].map((mileage) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleMileageSelection(mileage);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedMileages.contains(mileage)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        mileage,
                        style: h6.copyWith(
                          color: controller.selectedMileages.contains(mileage)
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
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Automatic', 'Manual'].map((transmission) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleTransmissionSelection(transmission);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedTransmissions.contains(transmission)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Text(
                        transmission,
                        style: h6.copyWith(
                          color: controller.selectedTransmissions.contains(transmission)
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            sh12,
            // Customer Reviews
            Text(
              'Reviews',
              style: h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
                  () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.ratings.map((rating) {
                  return GestureDetector(
                    onTap: () {
                      controller.toggleRatingSelection(rating);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.selectedRatings.contains(rating)
                            ? AppColors.darkRed
                            : AppColors.silver,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star,
                              color: controller.selectedRatings.contains(rating)
                                  ? Colors.white
                                  : Colors.orange,
                              size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '$rating',
                            style: h6.copyWith(
                              color: controller.selectedRatings.contains(rating)
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            sh12,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.silver)),
          color: AppColors.bottomNavbar,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                Get.back(result: controller.getSelectedFilters());
              },
              textStyle: h4.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}