class AllMeetsModel {
  AllMeetsModel({
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
  final List<AllMeetsItemModel> data;

  factory AllMeetsModel.fromJson(Map<String, dynamic> json) {
    return AllMeetsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllMeetsItemModel>.from(
              json["data"]!.map((x) => AllMeetsItemModel.fromJson(x))),
    );
  }
}

class AllMeetsItemModel {
  AllMeetsItemModel({
    required this.id,
    required this.title,
    required this.modelType,
    required this.reference,
    required this.entryFee,
    required this.time,
    required this.date,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.locationUrl,
    required this.eventDetails,
    required this.coverPhoto,
    required this.author,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? modelType;
  final String? reference;
  final int? entryFee;
  final String? time;
  final DateTime? date;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? locationUrl;
  final String? eventDetails;
  final String? coverPhoto;
  final Author? author;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AllMeetsItemModel.fromJson(Map<String, dynamic> json) {
    return AllMeetsItemModel(
      id: json["_id"],
      title: json["title"],
      modelType: json["modelType"],
      reference: json["reference"],
      entryFee: json["entryFee"],
      time: json["time"],
      date: DateTime.tryParse(json["date"] ?? ""),
      location: json["location"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      locationUrl: json["locationUrl"],
      eventDetails: json["eventDetails"],
      coverPhoto: json["coverPhoto"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Author {
  Author({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      photoUrl: json["photoUrl"],
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
