class AllProfilesModel {
    AllProfilesModel({
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
    final List<AllProfileItemModel> data;

    factory AllProfilesModel.fromJson(Map<String, dynamic> json){ 
        return AllProfilesModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<AllProfileItemModel>.from(json["data"]!.map((x) => AllProfileItemModel.fromJson(x))),
        );
    }

}

class AllProfileItemModel {
    AllProfileItemModel({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
        required this.coverPhoto,
        required this.bio,
        required this.address,
        required this.status,
        required this.datumId,
        required this.createdAt,
        required this.isConnect,
        required this.connectStatus,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;
    final String? coverPhoto;
    final String? bio;
    final String? address;
    final String? status;
    final String? datumId;
    final DateTime? createdAt;
    final bool? isConnect;
    final String? connectStatus;

    factory AllProfileItemModel.fromJson(Map<String, dynamic> json){ 
        return AllProfileItemModel(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
            coverPhoto: json["coverPhoto"],
            bio: json["bio"],
            address: json["address"],
            status: json["status"],
            datumId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            isConnect: json["isConnect"],
            connectStatus: json["connectStatus"],
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
