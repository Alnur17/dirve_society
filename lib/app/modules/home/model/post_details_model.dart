class PostDetailsModel {
  PostDetailsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? statusCode;
  final String? message;
  final PostData? data;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) {
    return PostDetailsModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: json["data"] == null ? null : PostData.fromJson(json["data"]),
    );
  }
}

class PostData {
  PostData({
    required this.hideBy,
    required this.id,
    required this.author,
    required this.club,
    required this.content,
    required this.description,
    required this.tags,
    required this.contentMeta,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
    required this.isVisible,
    required this.isFavorite,
    required this.isHide,
  });

  final List<dynamic> hideBy;
  final String? id;
  final Author? author;
  final String? club;
  final List<String> content;
  final String? description;
  final List<String> tags;
  final ContentMeta? contentMeta;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isLiked;
  final bool? isVisible;
  final bool? isFavorite;
  final bool? isHide;

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      hideBy: json["hideBy"] == null
          ? []
          : List<dynamic>.from(json["hideBy"]!.map((x) => x)),
      id: json["_id"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      club: json["club"],
      content: json["content"] == null
          ? []
          : List<String>.from(json["content"]!.map((x) => x)),
      description: json["description"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      contentMeta: json["contentMeta"] == null
          ? null
          : ContentMeta.fromJson(json["contentMeta"]),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      isLiked: json["isLiked"],
      isVisible: json["isVisible"],
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

  factory Author.fromJson(Map<String, dynamic> json) {
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
  });

  final String? id;
  final int? like;
  final List<dynamic> likeBy;
  final int? comment;

  factory ContentMeta.fromJson(Map<String, dynamic> json) {
    return ContentMeta(
      id: json["_id"],
      like: json["like"],
      likeBy: json["likeBy"] == null
          ? []
          : List<dynamic>.from(json["likeBy"]!.map((x) => x)),
      comment: json["comment"],
    );
  }
}
