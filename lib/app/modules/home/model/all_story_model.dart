class AllStoryModel {
  AllStoryModel({
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
  final List<AllStoryItemModel> data;

  factory AllStoryModel.fromJson(Map<String, dynamic> json) {
    return AllStoryModel(
      success: json["success"],
      statusCode: json["statusCode"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllStoryItemModel>.from(
              json["data"]!.map((x) => AllStoryItemModel.fromJson(x))),
    );
  }
}

class AllStoryItemModel {
  AllStoryItemModel({
    required this.user,
  });

  final User? user;

  factory AllStoryItemModel.fromJson(Map<String, dynamic> json) {
    return AllStoryItemModel(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.userId,
    required this.name,
    required this.photoUrl,
    required this.stories,
  });

  final String? userId;
  final String? name;
  final String? photoUrl;
  final List<Story> stories;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      name: json["name"],
      photoUrl: json["photoUrl"],
      stories: json["stories"] == null
          ? []
          : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
    );
  }
}

class Story {
  Story({
    required this.content,
    required this.text,
    required this.createdAt,
  });

  final String? content;
  final String? text;
  final DateTime? createdAt;

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      content: json["content"],
      text: json["text"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
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
