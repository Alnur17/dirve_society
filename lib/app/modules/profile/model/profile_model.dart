class ProfileDetailsModel {
    ProfileDetailsModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final ProfileData? data;

    factory ProfileDetailsModel.fromJson(Map<String, dynamic> json){ 
        return ProfileDetailsModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
        );
    }

}

class ProfileData {
    ProfileData({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
        required this.bio,
        required this.address,
        required this.scores,
        required this.status,
        required this.dataId,
        required this.createdAt,
        required this.avgRating,
        required this.coverPhoto,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;
    final String? bio;
    final String? address;
    final int? scores;
    final String? status;
    final String? dataId;
    final DateTime? createdAt;
    final dynamic avgRating;
    final String? coverPhoto;

    factory ProfileData.fromJson(Map<String, dynamic> json){ 
        return ProfileData(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
            bio: json["bio"],
            address: json["address"],
            scores: json["scores"],
            status: json["status"],
            dataId: json["id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            avgRating: json["avgRating"],
            coverPhoto: json["coverPhoto"],
        );
    }

}
