class CarRatingModel {
  CarRatingModel({
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
  final List<CarRatingItemModel> data;

  factory CarRatingModel.fromJson(Map<String, dynamic> json) {
    return CarRatingModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<CarRatingItemModel>.from(
              json["data"]!.map((x) => CarRatingItemModel.fromJson(x))),
    );
  }
}

class CarRatingItemModel {
  CarRatingItemModel({
    required this.id,
    required this.description,
    required this.banner,
    required this.author,
    required this.contentMeta,
    required this.isLiked,
    required this.isDisliked,
  });

  final String? id;
  final String? description;
  final String? banner;
  final Author? author;
  final ContentMeta? contentMeta;
  final bool? isLiked;
  final bool? isDisliked;

  factory CarRatingItemModel.fromJson(Map<String, dynamic> json) {
    return CarRatingItemModel(
      id: json["_id"],
      description: json["description"],
      banner: json["banner"],
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
      contentMeta: json["contentMeta"] == null
          ? null
          : ContentMeta.fromJson(json["contentMeta"]),
      isLiked: json["isLiked"],
      isDisliked: json["isDisliked"],
    );
  }
}

class Author {
  Author({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  final String? id;
  final String? name;
  final String? photoUrl;

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json["_id"],
      name: json["name"],
      photoUrl: json["photoUrl"],
    );
  }
}

class ContentMeta {
  ContentMeta({
    required this.id,
    required this.like,
    required this.likeBy,
    required this.disLikeBy,
  });

  final String? id;
  final int? like;
  final List<String> likeBy;
  final List<dynamic> disLikeBy;

  factory ContentMeta.fromJson(Map<String, dynamic> json) {
    return ContentMeta(
      id: json["_id"],
      like: json["like"],
      likeBy: json["likeBy"] == null
          ? []
          : List<String>.from(json["likeBy"]!.map((x) => x)),
      disLikeBy: json["disLikeBy"] == null
          ? []
          : List<dynamic>.from(json["disLikeBy"]!.map((x) => x)),
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
