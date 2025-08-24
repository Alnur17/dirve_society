class DiscoverClubModel {
    DiscoverClubModel({
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
    final List<DiscoverClubItemModel> data;

    factory DiscoverClubModel.fromJson(Map<String, dynamic> json){ 
        return DiscoverClubModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<DiscoverClubItemModel>.from(json["data"]!.map((x) => DiscoverClubItemModel.fromJson(x))),
        );
    }

}

class DiscoverClubItemModel {
    DiscoverClubItemModel({
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
    final bool? isOwner;

    factory DiscoverClubItemModel.fromJson(Map<String, dynamic> json){ 
        return DiscoverClubItemModel(
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

    factory Owner.fromJson(Map<String, dynamic> json){ 
        return Owner(
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

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
