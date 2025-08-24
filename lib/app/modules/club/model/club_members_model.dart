class ClubMembersModel {
  ClubMembersModel({
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
  final List<ClubMembersItemModel> data;

  factory ClubMembersModel.fromJson(Map<String, dynamic> json) {
    return ClubMembersModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<ClubMembersItemModel>.from(
              json["data"]!.map((x) => ClubMembersItemModel.fromJson(x))),
    );
  }
}

class ClubMembersItemModel {
  ClubMembersItemModel({
    required this.id,
    required this.user,
    required this.modelType,
    required this.reference,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final User? user;
  final String? modelType;
  final String? reference;
  final String? status;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ClubMembersItemModel.fromJson(Map<String, dynamic> json) {
    return ClubMembersItemModel(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      modelType: json["modelType"],
      reference: json["reference"],
      status: json["status"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? photoUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
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
