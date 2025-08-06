class AllPendingConnectionModel {
    AllPendingConnectionModel({
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
    final List<AllPendingConnectionItemModel> data;

    factory AllPendingConnectionModel.fromJson(Map<String, dynamic> json){ 
        return AllPendingConnectionModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllPendingConnectionItemModel>.from(json["data"]!.map((x) => AllPendingConnectionItemModel.fromJson(x))),
        );
    }

}

class AllPendingConnectionItemModel {
    AllPendingConnectionItemModel({
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
    final String? user;
    final String? modelType;
    final Reference? reference;
    final String? status;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory AllPendingConnectionItemModel.fromJson(Map<String, dynamic> json){ 
        return AllPendingConnectionItemModel(
            id: json["_id"],
            user: json["user"],
            modelType: json["modelType"],
            reference: json["reference"] == null ? null : Reference.fromJson(json["reference"]),
            status: json["status"],
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class Reference {
    Reference({
        required this.ratingCount,
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.bio,
    });

    final int? ratingCount;
    final String? id;
    final String? name;
    final String? photoUrl;
    final String? bio;

    factory Reference.fromJson(Map<String, dynamic> json){ 
        return Reference(
            ratingCount: json["ratingCount"],
            id: json["_id"],
            name: json["name"],
            photoUrl: json["photoUrl"],
            bio: json["bio"],
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
