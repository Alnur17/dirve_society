import 'package:get/get.dart';

class FilterController extends GetxController {
  // Observable variables for single selection
  final minPrice = ''.obs;
  final maxPrice = ''.obs;
  final selectedRange = ''.obs;
  final selectedBrand = ''.obs;
  final selectedCondition = ''.obs;
  final selectedVehicleType = ''.obs;
  final selectedYear = 0.obs;
  final selectedColor = ''.obs;
  final selectedMileage = ''.obs;
  final selectedTransmission = ''.obs;
  final selectedStore = ''.obs;
  final selectedRating = 0.obs;

  // Data sources
  final List<String> brands = ['Toyota', 'Honda', 'BMW', 'Jeep', 'Audi', 'Mazda', 'Nissan'];
  final List<String> conditions = ['New', 'Used'];
  final List<String> vehicleTypes = ['SUV', 'Sedan', 'Coupe', 'Hatchback', 'Van'];
  final List<int> years = [2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025];
  final List<String> colors = ['Black', 'White', 'Red'];
  final List<String> mileages = ['10000', '20000', '30000', '40000'];
  final List<String> transmissions = ['Automatic', 'Manual'];
  final List<String> stores = ['TechHaven', 'Gadget Galaxy', 'TechTrends'];
  final List<int> ratings = [1, 2, 3, 4, 5];

  // Methods to set price
  void setMinPrice(String price) => minPrice.value = price;

  void setMaxPrice(String price) => maxPrice.value = price;

  void setSelectedRange(String range) => selectedRange.value = range;

  // Methods to select one item at a time
  void selectBrand(String brand) {
    selectedBrand.value = (selectedBrand.value == brand) ? '' : brand;
  }

  void selectCondition(String condition) {
    selectedCondition.value = (selectedCondition.value == condition) ? '' : condition;
  }

  void selectVehicleType(String type) {
    selectedVehicleType.value = (selectedVehicleType.value == type) ? '' : type;
  }

  void selectYear(int year) {
    selectedYear.value = (selectedYear.value == year) ? 0 : year;
  }

  void selectColor(String color) {
    selectedColor.value = (selectedColor.value == color) ? '' : color;
  }

  void selectMileage(String mileage) {
    selectedMileage.value = (selectedMileage.value == mileage) ? '' : mileage;
  }

  void selectTransmission(String transmission) {
    selectedTransmission.value = (selectedTransmission.value == transmission) ? '' : transmission;
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
    selectedYear.value = 0;
    selectedColor.value = '';
    selectedMileage.value = '';
    selectedTransmission.value = '';
    selectedStore.value = '';
    selectedRating.value = 0;
  }

  // Return selected filters as a map
  Map<String, dynamic> getSelectedFilters() {
    final filters = <String, dynamic>{};
    if (minPrice.value.isNotEmpty) filters['Min Price'] = minPrice.value;
    if (maxPrice.value.isNotEmpty) filters['Max Price'] = maxPrice.value;
    if (selectedRange.value.isNotEmpty) filters['Selected Range'] = selectedRange.value;
    if (selectedBrand.value.isNotEmpty) filters['Brands'] = selectedBrand.value;
    if (selectedCondition.value.isNotEmpty) filters['Condition'] = selectedCondition.value;
    if (selectedVehicleType.value.isNotEmpty) filters['Vehicle Type'] = selectedVehicleType.value;
    if (selectedYear.value != 0) filters['Year'] = selectedYear.value;
    if (selectedColor.value.isNotEmpty) filters['Colours'] = selectedColor.value;
    if (selectedMileage.value.isNotEmpty) filters['Mileage'] = selectedMileage.value;
    if (selectedTransmission.value.isNotEmpty) filters['Transmission'] = selectedTransmission.value;
    if (selectedStore.value.isNotEmpty) filters['Store'] = selectedStore.value;
    if (selectedRating.value != 0) filters['Reviews'] = selectedRating.value;
    return filters;
  }
}