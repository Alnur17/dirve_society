import 'package:get/get.dart';
import '../controllers/all_filter_controller.dart';

class FilterController extends GetxController {
  final AllFilterController allFilterController = Get.find();

  // Selected
  final minPrice = ''.obs;
  final maxPrice = ''.obs;
  final selectedBrand = ''.obs;
  final selectedModel = ''.obs; // Independent
  final minYear = ''.obs;
  final maxYear = ''.obs;
  final selectedCondition = ''.obs;
  final selectedColor = ''.obs;
  final maxMileage = ''.obs;
  final minEngineSize = ''.obs;
  final maxEngineSize = ''.obs;
  final selectedTransmission = ''.obs;

  // Data Lists
  final RxList<String> brands = <String>[].obs;
  final RxList<String> models = <String>[].obs;     // All models
  final RxList<String> conditions = <String>[].obs;
  final RxList<String> years = <String>[].obs;
  final RxList<String> colors = <String>[].obs;
  final RxList<String> transmissions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilterData();
  }

  Future<void> fetchFilterData() async {
    final success = await allFilterController.getAllFilter('filter');
    if (success && allFilterController.allReviewModel != null) {
      final data = allFilterController.allReviewModel!;

      brands.assignAll(data.brand);
      models.assignAll(data.model); // সব মডেল
      conditions.assignAll(data.condition);
      years.assignAll(data.year);
      colors.assignAll(data.color);
      transmissions.assignAll(data.transmission);
    }
  }

  // Toggle
  void selectBrand(String brand) {
    selectedBrand.value = selectedBrand.value == brand ? '' : brand;
    // Model reset হবে না!
  }

  void selectModel(String model) {
    selectedModel.value = selectedModel.value == model ? '' : model;
  }

  void selectCondition(String c) {
    selectedCondition.value = selectedCondition.value == c ? '' : c;
  }

  void selectColor(String c) => selectedColor.value = c;
  void selectTransmission(String t) {
    selectedTransmission.value = selectedTransmission.value == t ? '' : t;
  }

  void resetFilters() {
    minPrice.value = maxPrice.value = '';
    selectedBrand.value = selectedModel.value = '';
    minYear.value = maxYear.value = '';
    selectedCondition.value = selectedColor.value = '';
    maxMileage.value = minEngineSize.value = maxEngineSize.value = '';
    selectedTransmission.value = '';
  }

  Map<String, dynamic> getSelectedFilters() {
    final Map<String, dynamic> filters = {};

    if (minPrice.value.isNotEmpty) filters['min_price'] = minPrice.value;
    if (maxPrice.value.isNotEmpty) filters['max_price'] = maxPrice.value;
    if (selectedBrand.value.isNotEmpty) filters['brand'] = selectedBrand.value;
    if (selectedModel.value.isNotEmpty) filters['model'] = selectedModel.value;
    if (minYear.value.isNotEmpty) filters['min_year'] = minYear.value;
    if (maxYear.value.isNotEmpty) filters['max_year'] = maxYear.value;
    if (selectedCondition.value.isNotEmpty) filters['condition'] = selectedCondition.value;
    if (selectedColor.value.isNotEmpty) filters['color'] = selectedColor.value;
    if (maxMileage.value.isNotEmpty) filters['max_mileage'] = maxMileage.value;
    if (minEngineSize.value.isNotEmpty) filters['min_engine_size'] = minEngineSize.value;
    if (maxEngineSize.value.isNotEmpty) filters['max_engine_size'] = maxEngineSize.value;
    if (selectedTransmission.value.isNotEmpty) filters['transmission'] = selectedTransmission.value;

    return filters;
  }
}