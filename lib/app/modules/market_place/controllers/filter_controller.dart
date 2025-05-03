import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  Rx<RangeValues> priceRange = const RangeValues(0, 500).obs;
  RxString selectedRange = ''.obs;

  // Data sources
  final List<String> brands = ['Toyota', 'Honda', 'BMW', 'Jeep', 'Audi', 'Mazda', 'Nissan'];
  final List<String> conditions = ['New', 'Used'];
  final List<String> vehicleTypes = ['SUV', 'Sedan', 'Coupe', 'Hatchback', 'Van'];
  final List<int> years = [2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018];
  final List<String> colors = ['Black', 'White', 'Red'];
  final List<String> mileages = ['<10,000 miles', '20,000 miles', '30,000 miles', '40,000 miles>'];
  final List<String> transmissions = ['Automatic', 'Manual'];
  final List<String> stores = ['TechHaven', 'Gadget Galaxy', 'TechTrends'];
  final List<int> ratings = [1, 2, 3, 4, 5];

  // Selected items
  RxList<String> selectedBrands = <String>[].obs;
  RxList<String> selectedConditions = <String>[].obs;
  RxList<String> selectedVehicleTypes = <String>[].obs;
  RxList<int> selectedYears = <int>[].obs;
  RxList<String> selectedColors = <String>[].obs;
  RxList<String> selectedMileages = <String>[].obs;
  RxList<String> selectedTransmissions = <String>[].obs;
  RxList<String> selectedStores = <String>[].obs;
  RxList<int> selectedRatings = <int>[].obs;

  // Methods to toggle selections
  void setPriceRange(RangeValues values) => priceRange.value = values;

  void toggleBrandSelection(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
  }

  void toggleConditionSelection(String condition) {
    if (selectedConditions.contains(condition)) {
      selectedConditions.remove(condition);
    } else {
      selectedConditions.add(condition);
    }
  }

  void toggleVehicleTypeSelection(String type) {
    if (selectedVehicleTypes.contains(type)) {
      selectedVehicleTypes.remove(type);
    } else {
      selectedVehicleTypes.add(type);
    }
  }

  void toggleYearSelection(int year) {
    if (selectedYears.contains(year)) {
      selectedYears.remove(year);
    } else {
      selectedYears.add(year);
    }
  }

  void toggleColorSelection(String color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
  }

  void toggleMileageSelection(String mileage) {
    if (selectedMileages.contains(mileage)) {
      selectedMileages.remove(mileage);
    } else {
      selectedMileages.add(mileage);
    }
  }

  void toggleTransmissionSelection(String transmission) {
    if (selectedTransmissions.contains(transmission)) {
      selectedTransmissions.remove(transmission);
    } else {
      selectedTransmissions.add(transmission);
    }
  }

  void toggleStoreSelection(String store) {
    if (selectedStores.contains(store)) {
      selectedStores.remove(store);
    } else {
      selectedStores.add(store);
    }
  }

  void toggleRatingSelection(int rating) {
    if (selectedRatings.contains(rating)) {
      selectedRatings.remove(rating);
    } else {
      selectedRatings.add(rating);
    }
  }

  // Reset all filters
  void resetFilters() {
    priceRange.value = const RangeValues(0, 500);
    selectedRange.value = '';
    selectedBrands.clear();
    selectedConditions.clear();
    selectedVehicleTypes.clear();
    selectedYears.clear();
    selectedColors.clear();
    selectedMileages.clear();
    selectedTransmissions.clear();
    selectedStores.clear();
    selectedRatings.clear();
  }

  // Return selected filters as a map
  Map<String, dynamic> getSelectedFilters() {
    return {
      'priceRange': priceRange.value,
      'selectedRange': selectedRange.value,
      'selectedBrands': selectedBrands,
      'selectedConditions': selectedConditions,
      'selectedVehicleTypes': selectedVehicleTypes,
      'selectedYears': selectedYears,
      'selectedColors': selectedColors,
      'selectedMileages': selectedMileages,
      'selectedTransmissions': selectedTransmissions,
      'selectedStores': selectedStores,
      'selectedRatings': selectedRatings,
    };
  }
}