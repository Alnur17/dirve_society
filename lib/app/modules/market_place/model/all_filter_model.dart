class AllFilterModel {
  AllFilterModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final FilterData? data;

  factory AllFilterModel.fromJson(Map<String, dynamic> json) {
    return AllFilterModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : FilterData.fromJson(json["data"]),
    );
  }
}

class FilterData {
  FilterData({
    required this.priceRange,
    required this.brand,
    required this.model,
    required this.condition,
    required this.color,
    required this.year,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
  });

  final String? priceRange;
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
      priceRange: json["priceRange"],
      brand: json["brand"] == null
          ? []
          : List<String>.from(json["brand"]!.map((x) => x)),
      model: json["model"] == null
          ? []
          : List<String>.from(json["model"]!.map((x) => x)),
      condition: json["condition"] == null
          ? []
          : List<String>.from(json["condition"]!.map((x) => x)),
      color: json["color"] == null
          ? []
          : List<String>.from(json["color"]!.map((x) => x)),
      year: json["year"] == null
          ? []
          : List<String>.from(json["year"]!.map((x) => x)),
      mileage: json["mileage"] == null
          ? []
          : List<int>.from(json["mileage"]!.map((x) => x)),
      fuelType: json["fuelType"] == null
          ? []
          : List<String>.from(json["fuelType"]!.map((x) => x)),
      transmission: json["transmission"] == null
          ? []
          : List<String>.from(json["transmission"]!.map((x) => x)),
    );
  }
}
