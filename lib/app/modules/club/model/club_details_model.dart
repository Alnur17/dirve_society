class ClubDetailsModel {
  ClubDetailsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final ClubData? data;

  factory ClubDetailsModel.fromJson(Map<String, dynamic> json) {
    return ClubDetailsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : ClubData.fromJson(json["data"]),
    );
  }
}

class ClubData {
  ClubData({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.profilePhoto,
    required this.coverPhoto,
    required this.member,
    required this.owner,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isOwner,
  });

  final String? id;
  final String? name;
  final String? type;
  final String? description;
  final String? profilePhoto;
  final String? coverPhoto;
  final int? member;
  final Owner? owner;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isOwner;

  factory ClubData.fromJson(Map<String, dynamic> json) {
    return ClubData(
      id: json["_id"],
      name: json["name"],
      type: json["type"],
      description: json["description"],
      profilePhoto: json["profilePhoto"],
      coverPhoto: json["coverPhoto"],
      member: json["member"],
      owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      isOwner: json["isOwner"],
    );
  }
}

class Owner {
  Owner({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? photoUrl;

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json["_id"],
      name: json["name"],
      photoUrl: json["photoUrl"],
    );
  }
}
