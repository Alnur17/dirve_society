class PeopleYouMayModel {
    PeopleYouMayModel({
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
    final List<PeopleYouMayItemModel> data;

    factory PeopleYouMayModel.fromJson(Map<String, dynamic> json){ 
        return PeopleYouMayModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<PeopleYouMayItemModel>.from(json["data"]!.map((x) => PeopleYouMayItemModel.fromJson(x))),
        );
    }

}

class PeopleYouMayItemModel {
    PeopleYouMayItemModel({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
        required this.coverPhoto,
        required this.bio,
        required this.avgRating,
        required this.ratingCount,
        required this.createdAt,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;
    final String? coverPhoto;
    final String? bio;
    final dynamic avgRating;
    final int? ratingCount;
    final DateTime? createdAt;

    factory PeopleYouMayItemModel.fromJson(Map<String, dynamic> json){ 
        return PeopleYouMayItemModel(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
            coverPhoto: json["coverPhoto"],
            bio: json["bio"],
            avgRating: json["avgRating"],
            ratingCount: json["ratingCount"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
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
