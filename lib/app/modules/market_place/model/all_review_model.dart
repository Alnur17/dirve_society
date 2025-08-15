class AllReviewModel {
    AllReviewModel({
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
    final List<AllReviewItemModel> data;

    factory AllReviewModel.fromJson(Map<String, dynamic> json){ 
        return AllReviewModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllReviewItemModel>.from(json["data"]!.map((x) => AllReviewItemModel.fromJson(x))),
        );
    }

}

class AllReviewItemModel {
    AllReviewItemModel({
        required this.id,
        required this.user,
        required this.modelType,
        required this.reference,
        required this.review,
        required this.rating,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final User? user;
    final String? modelType;
    final String? reference;
    final String? review;
    final dynamic rating;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllReviewItemModel.fromJson(Map<String, dynamic> json){ 
        return AllReviewItemModel(
            id: json["_id"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            modelType: json["modelType"],
            reference: json["reference"],
            review: json["review"],
            rating: json["rating"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
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

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPage: json["totalPage"],
        );
    }

}
