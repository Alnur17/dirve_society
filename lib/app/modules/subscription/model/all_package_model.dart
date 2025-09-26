class AllPackageModel {
  AllPackageModel({
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
  final List<AllPackageItemModel> data;

  factory AllPackageModel.fromJson(Map<String, dynamic> json) {
    return AllPackageModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllPackageItemModel>.from(
              json["data"]!.map((x) => AllPackageItemModel.fromJson(x))),
    );
  }
}

class AllPackageItemModel {
  AllPackageItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllPackageItemModel.fromJson(Map<String, dynamic> json) {
    return AllPackageItemModel(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
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
