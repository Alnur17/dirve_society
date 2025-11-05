class AllFilterModel {
  AllFilterModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool success;
  final int statusCode;
  final String message;
  final FilterData? data;

  factory AllFilterModel.fromJson(Map<String, dynamic> json) {
    return AllFilterModel(
      success: json["success"] as bool,
      statusCode: json["statusCode"] as int,
      message: json["message"] as String,
      data: json["data"] == null
          ? null
          : FilterData.fromJson(json["data"] as Map<String, dynamic>),
    );
  }
}

class FilterData {
  FilterData({
    required this.priceRange,
    required this.mileageRange,
    required this.brand,
    required this.model,
    required this.condition,
    required this.color,
    required this.year,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
  });

  final String priceRange;
  final String mileageRange; 
  final List<String> brand;
  final List<String> model;
  final List<String> condition;
  final List<String> color;
  final List<String> year;
  final List<int> mileage;
  final List<String> fuelType;
  final List<String> transmission;

  factory FilterData.fromJson(Map<String, dynamic> json) {
    return FilterData(
      priceRange: json["priceRange"] as String? ?? '',
      mileageRange: json["mileageRange"] as String? ?? '',   // নতুন
      brand: _toStringList(json["brand"]),
      model: _toStringList(json["model"]),
      condition: _toStringList(json["condition"]),
      color: _toStringList(json["color"]),
      year: _toStringList(json["year"]),
      mileage: json["mileage"] == null
          ? <int>[]
          : List<int>.from((json["mileage"] as List).map((x) => x as int)),
      fuelType: _toStringList(json["fuelType"]),
      transmission: _toStringList(json["transmission"]),
    );
  }

  // Helper function
  static List<String> _toStringList(dynamic value) {
    if (value == null) return <String>[];
    return List<String>.from((value as List).map((x) => x.toString()));
  }
}