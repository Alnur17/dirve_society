class ContectModel {
    ContectModel({
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
    final List<ContentItemModel> data;

    factory ContectModel.fromJson(Map<String, dynamic> json){ 
        return ContectModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<ContentItemModel>.from(json["data"]!.map((x) => ContentItemModel.fromJson(x))),
        );
    }

}

class ContentItemModel {
    ContentItemModel({
        required this.id,
        required this.aboutUs,
        required this.termsAndConditions,
        required this.privacyPolicy,
        required this.supports,
        required this.faq,
        required this.isDeleted,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? aboutUs;
    final String? termsAndConditions;
    final String? privacyPolicy;
    final String? supports;
    final String? faq;
    final bool? isDeleted;
    final CreatedBy? createdBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory ContentItemModel.fromJson(Map<String, dynamic> json){ 
        return ContentItemModel(
            id: json["_id"],
            aboutUs: json["aboutUs"],
            termsAndConditions: json["termsAndConditions"],
            privacyPolicy: json["privacyPolicy"],
            supports: json["supports"],
            faq: json["faq"],
            isDeleted: json["isDeleted"],
            createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class CreatedBy {
    CreatedBy({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
        required this.status,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;
    final String? status;

    factory CreatedBy.fromJson(Map<String, dynamic> json){ 
        return CreatedBy(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
            status: json["status"],
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
