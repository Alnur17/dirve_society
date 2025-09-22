import 'package:get/get.dart';
import '../controllers/all_filter_controller.dart';

class FilterController extends GetxController {
  final AllFilterController allFilterController =
      Get.find<AllFilterController>();

  // Observable variables for single selection
  final minPrice = ''.obs;
  final maxPrice = ''.obs;
  final selectedRange = ''.obs;
  final selectedBrand = ''.obs;
  final selectedCondition = ''.obs;
  final selectedVehicleType = ''.obs;
  final selectedYear = ''.obs; // Changed to String to match FilterData.year
  final selectedColor = ''.obs;
  final selectedMileage = 0.obs; // Kept as int to match FilterData.mileage
  final selectedTransmission = ''.obs;
  final selectedStore = ''.obs;
  final selectedRating = 0.obs;

  // Dynamic data sources
  final RxList<String> brands = <String>[].obs;
  final RxList<String> conditions = <String>[].obs;
  final RxList<String> vehicleTypes =
      <String>[].obs; // Assuming model is vehicleTypes
  final RxList<String> years = <String>[].obs;
  final RxList<String> colors = <String>[].obs;
  final RxList<int> mileages = <int>[].obs;
  final RxList<String> transmissions = <String>[].obs;
  final RxList<String> stores =
      <String>[].obs; // Static for now, update if API provides
  final RxList<int> ratings = <int>[1, 2, 3, 4, 5].obs; // Static for now

  @override
  void onInit() {
    super.onInit();
    fetchFilterData();
  }

  // Fetch data from AllFilterController
  Future<void> fetchFilterData() async {
    final bool success = await allFilterController
        .getAllFilter('some_content_id'); // Replace with actual contentId
    if (success && allFilterController.allReviewModel != null) {
      final filterData = allFilterController.allReviewModel!;
      brands.assignAll(filterData.brand);
      conditions.assignAll(filterData.condition);
      vehicleTypes
          .assignAll(filterData.model); // Assuming model maps to vehicleTypes
      years.assignAll(filterData.year);
      colors.assignAll(filterData.color);
      mileages.assignAll(filterData.mileage);
      transmissions.assignAll(filterData.transmission);
      // If stores are provided by API, update here
      // stores.assignAll(filterData.someStoreField ?? []);
    }
  }

  // Methods to set price
  void setMinPrice(String price) => minPrice.value = price;

  void setMaxPrice(String price) => maxPrice.value = price;

  void setSelectedRange(String range) => selectedRange.value = range;

  // Methods to select one item at a time
  void selectBrand(String brand) {
    selectedBrand.value = (selectedBrand.value == brand) ? '' : brand;
  }

  void selectCondition(String condition) {
    selectedCondition.value =
        (selectedCondition.value == condition) ? '' : condition;
  }

  void selectVehicleType(String type) {
    selectedVehicleType.value = (selectedVehicleType.value == type) ? '' : type;
  }

  void selectYear(String year) {
    selectedYear.value = (selectedYear.value == year) ? '' : year;
  }

  void selectColor(String color) {
    selectedColor.value = (selectedColor.value == color) ? '' : color;
  }

  void selectMileage(int mileage) {
    selectedMileage.value = (selectedMileage.value == mileage) ? 0 : mileage;
  }

  void selectTransmission(String transmission) {
    selectedTransmission.value =
        (selectedTransmission.value == transmission) ? '' : transmission;
  }

  void selectStore(String store) {
    selectedStore.value = (selectedStore.value == store) ? '' : store;
  }

  void selectRating(int rating) {
    selectedRating.value = (selectedRating.value == rating) ? 0 : rating;
  }

  // Reset all filters
  void resetFilters() {
    minPrice.value = '';
    maxPrice.value = '';
    selectedRange.value = '';
    selectedBrand.value = '';
    selectedCondition.value = '';
    selectedVehicleType.value = '';
    selectedYear.value = '';
    selectedColor.value = '';
    selectedMileage.value = 0;
    selectedTransmission.value = '';
    selectedStore.value = '';
    selectedRating.value = 0;
  }

  // Return selected filters as a map
  Map<String, dynamic> getSelectedFilters() {
    final filters = <String, dynamic>{};
    if (minPrice.value.isNotEmpty && maxPrice.value.isNotEmpty) {
      filters['priceRange'] = '$minPrice-$maxPrice';
    }
    if (selectedBrand.value.isNotEmpty) filters['Brands'] = selectedBrand.value;
    if (selectedCondition.value.isNotEmpty) {
      filters['Condition'] = selectedCondition.value;
    }
    if (selectedVehicleType.value.isNotEmpty) {
      filters['Vehicle Type'] = selectedVehicleType.value;
    }
    if (selectedYear.value.isNotEmpty) filters['Year'] = selectedYear.value;
    if (selectedColor.value.isNotEmpty) {
      filters['Colours'] = selectedColor.value;
    }
    if (selectedMileage.value != 0) filters['Mileage'] = selectedMileage.value;
    if (selectedTransmission.value.isNotEmpty) {
      filters['Transmission'] = selectedTransmission.value;
    }
    if (selectedStore.value.isNotEmpty) filters['Store'] = selectedStore.value;
    if (selectedRating.value != 0) filters['Reviews'] = selectedRating.value;
    return filters;
  }
}
