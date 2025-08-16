class ClubForumModel {
    ClubForumModel({
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
    final List<ClubForumItemModel> data;

    factory ClubForumModel.fromJson(Map<String, dynamic> json){ 
        return ClubForumModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? [] : List<ClubForumItemModel>.from(json["data"]!.map((x) => ClubForumItemModel.fromJson(x))),
        );
    }

}

class ClubForumItemModel {
    ClubForumItemModel({
        required this.id,
        required this.author,
        required this.club,
        required this.title,
        required this.description,
        required this.tags,
        required this.hideBy,
        required this.contentMeta,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.isLiked,
        required this.isDislike,
        required this.isFavorite,
        required this.isHide,
    });

    final String? id;
    final Author? author;
    final String? club;
    final String? title;
    final String? description;
    final List<String> tags;
    final List<dynamic> hideBy;
    final ContentMeta? contentMeta;
    final bool? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isLiked;
    final bool? isDislike;
    final bool? isFavorite;
    final bool? isHide;

    factory ClubForumItemModel.fromJson(Map<String, dynamic> json){ 
        return ClubForumItemModel(
            id: json["_id"],
            author: json["author"] == null ? null : Author.fromJson(json["author"]),
            club: json["club"],
            title: json["title"],
            description: json["description"],
            tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
            hideBy: json["hideBy"] == null ? [] : List<dynamic>.from(json["hideBy"]!.map((x) => x)),
            contentMeta: json["contentMeta"] == null ? null : ContentMeta.fromJson(json["contentMeta"]),
            isDeleted: json["isDeleted"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            isLiked: json["isLiked"],
            isDislike: json["isDislike"],
            isFavorite: json["isFavorite"],
            isHide: json["isHide"],
        );
    }

}

class Author {
    Author({
        required this.id,
        required this.name,
        required this.email,
        required this.photoUrl,
    });

    final String? id;
    final String? name;
    final String? email;
    final String? photoUrl;

    factory Author.fromJson(Map<String, dynamic> json){ 
        return Author(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
            photoUrl: json["photoUrl"],
        );
    }

}

class ContentMeta {
    ContentMeta({
        required this.id,
        required this.like,
        required this.likeBy,
        required this.comment,
        required this.disLikeBy,
    });

    final String? id;
    final int? like;
    final List<dynamic> likeBy;
    final int? comment;
    final List<dynamic> disLikeBy;

    factory ContentMeta.fromJson(Map<String, dynamic> json){ 
        return ContentMeta(
            id: json["_id"],
            like: json["like"],
            likeBy: json["likeBy"] == null ? [] : List<dynamic>.from(json["likeBy"]!.map((x) => x)),
            comment: json["comment"],
            disLikeBy: json["disLikeBy"] == null ? [] : List<dynamic>.from(json["disLikeBy"]!.map((x) => x)),
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
