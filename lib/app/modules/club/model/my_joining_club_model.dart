class MyJoiningClubModel {
    MyJoiningClubModel({
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
    final List<MyJoiningClubItemModel> data;

    factory MyJoiningClubModel.fromJson(Map<String, dynamic> json){ 
        return MyJoiningClubModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<MyJoiningClubItemModel>.from(json["data"]!.map((x) => MyJoiningClubItemModel.fromJson(x))),
        );
    }

}

class MyJoiningClubItemModel {
    MyJoiningClubItemModel({
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

    factory MyJoiningClubItemModel.fromJson(Map<String, dynamic> json){ 
        return MyJoiningClubItemModel(
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
        required this.id,
        required this.name,
        required this.type,
        required this.profilePhoto,
        required this.member,
    });

    final String? id;
    final String? name;
    final String? type;
    final String? profilePhoto;
    final int? member;

    factory Reference.fromJson(Map<String, dynamic> json){ 
        return Reference(
            id: json["_id"],
            name: json["name"],
            type: json["type"],
            profilePhoto: json["profilePhoto"],
            member: json["member"],
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
