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
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(AppImages.close, scale: 4),
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
                sh16,

                // Price
                _buildSectionTitle('Price'),
                sh8,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Min',
                        borderColor: AppColors.darkRed,
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.minPrice.value = v,
                      ),
                    ),
                    sw16,
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Max',
                        borderColor: AppColors.darkRed,
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.maxPrice.value = v,
                      ),
                    ),
                  ],
                ),
                sh16,

                // Brand
                Obx(() => _buildDropdown(
                      hint: 'Select Brand',
                      items: controller.brands,
                      selected: controller.selectedBrand.value,
                      onChanged: (val) => controller.selectBrand(val!),
                    )),
                sh12,

                // Model - Independent
                Obx(() => _buildDropdown(
                      hint: 'Select Model',
                      items: controller.models, // সব মডেল সবসময়
                      selected: controller.selectedModel.value,
                      onChanged: (val) => controller.selectModel(val!),
                    )),

                // Condition
                _buildSectionTitle('Condition'),
                sh8,
                Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.conditions.map((c) {
                        return _chip(
                          label: c,
                          selected: controller.selectedCondition.value == c,
                          onTap: () => controller.selectCondition(c),
                        );
                      }).toList(),
                    )),
                sh16,

                // Year
                _buildSectionTitle('Year'),
                sh8,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Min Year',
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.minYear.value = v,
                      ),
                    ),
                    sw16,
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Max Year',
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.maxYear.value = v,
                      ),
                    ),
                  ],
                ),
                sh16,

                // Colours
                _buildSectionTitle('Colours'),
                sh8,
                Obx(() => _buildDropdown(
                      hint: 'Select Colour',
                      items: [...controller.colors, 'Custom'],
                      selected: controller.selectedColor.value,
                      onChanged: (val) {
                        if (val == 'Custom') {
                          _showCustomColorDialog(context);
                        } else {
                          controller.selectColor(val!);
                        }
                      },
                    )),
                sh16,

                // Mileage
                _buildSectionTitle('Mileage'),
                sh8,
                CustomTextField(
                  hintText: 'Enter max mileage',
                  keyboardType: TextInputType.number,
                  onChange: (v) => controller.maxMileage.value = v,
                ),
                sh16,

                // Engine Size
                _buildSectionTitle('Engine Size (cc)'),
                sh8,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Min',
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.minEngineSize.value = v,
                      ),
                    ),
                    sw16,
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Max',
                        keyboardType: TextInputType.number,
                        onChange: (v) => controller.maxEngineSize.value = v,
                      ),
                    ),
                  ],
                ),
                sh16,

                // Transmission
                _buildSectionTitle('Transmission'),
                sh8,
                Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.transmissions.map((t) {
                        return _chip(
                          label: t,
                          selected: controller.selectedTransmission.value == t,
                          onTap: () => controller.selectTransmission(t),
                        );
                      }).toList(),
                    )),
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
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: h4.copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String selected,
    required Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      value: selected.isEmpty ? null : selected,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down),
    );
  }

  Widget _chip(
      {required String label,
      required bool selected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: selected ? AppColors.darkRed : AppColors.silver,
        ),
        child: Text(label,
            style: h6.copyWith(color: selected ? Colors.white : Colors.black)),
      ),
    );
  }

  void _showCustomColorDialog(BuildContext context) {
    final textController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Enter Custom Colour'),
        content: CustomTextField(
          controller: textController,
          hintText: 'e.g. Midnight Blue',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final color = textController.text.trim();
              if (color.isNotEmpty) controller.selectColor(color);
              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
