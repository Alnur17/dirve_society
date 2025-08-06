class AllMarketPlaceModel {
  AllMarketPlaceModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<AllMarketPlaceItemModel> data;

  factory AllMarketPlaceModel.fromJson(Map<String, dynamic> json) {
    return AllMarketPlaceModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllMarketPlaceItemModel>.from(
              json["data"]!.map((x) => AllMarketPlaceItemModel.fromJson(x))),
    );
  }
}

class AllMarketPlaceItemModel {
  AllMarketPlaceItemModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
    required this.description,
    required this.banner,
    required this.images,
    required this.price,
    required this.author,
    required this.contentMeta,
    required this.avgRating,
    required this.ratingCount,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? brand;
  final String? model;
  final int? mileage;
  final String? fuelType;
  final String? transmission;
  final String? description;
  final String? banner;
  final List<String> images;
  final int? price;
  final String? author;
  final String? contentMeta;
  final dynamic avgRating;
  final int? ratingCount;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllMarketPlaceItemModel.fromJson(Map<String, dynamic> json) {
    return AllMarketPlaceItemModel(
      id: json["_id"],
      brand: json["brand"],
      model: json["model"],
      mileage: json["mileage"],
      fuelType: json["fuelType"],
      transmission: json["transmission"],
      description: json["description"],
      banner: json["banner"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      price: json["price"],
      author: json["author"],
      contentMeta: json["contentMeta"],
      avgRating: json["avgRating"],
      ratingCount: json["ratingCount"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
