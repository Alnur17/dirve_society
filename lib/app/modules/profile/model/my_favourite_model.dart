class MyFavouriteModel {
  MyFavouriteModel({
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
  final List<MyFavouriteItemModel> data;

  factory MyFavouriteModel.fromJson(Map<String, dynamic> json) {
    return MyFavouriteModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<MyFavouriteItemModel>.from(
              json["data"]!.map((x) => MyFavouriteItemModel.fromJson(x))),
    );
  }
}

class MyFavouriteItemModel {
  MyFavouriteItemModel({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final User? user;
  final Content? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MyFavouriteItemModel.fromJson(Map<String, dynamic> json) {
    return MyFavouriteItemModel(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      content:
          json["content"] == null ? null : Content.fromJson(json["content"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Content {
  Content({
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
  });

  final List<dynamic> hideBy;
  final String? id;
  final String? author;
  final dynamic club;
  final List<String> content;
  final String? description;
  final List<String> tags;
  final ContentMeta? contentMeta;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      hideBy: json["hideBy"] == null
          ? []
          : List<dynamic>.from(json["hideBy"]!.map((x) => x)),
      id: json["_id"],
      author: json["author"],
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
    );
  }
}

class ContentMeta {
  ContentMeta({
    required this.id,
    required this.like,
    required this.comment,
    required this.view,
  });

  final String? id;
  final int? like;
  final int? comment;
  final int? view;

  factory ContentMeta.fromJson(Map<String, dynamic> json) {
    return ContentMeta(
      id: json["_id"],
      like: json["like"],
      comment: json["comment"],
      view: json["view"],
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

  factory User.fromJson(Map<String, dynamic> json) {
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
