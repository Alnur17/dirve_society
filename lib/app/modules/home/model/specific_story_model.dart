class SpecificStoryModel {
    SpecificStoryModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final StoryData? data;

    factory SpecificStoryModel.fromJson(Map<String, dynamic> json){ 
        return SpecificStoryModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? null : StoryData.fromJson(json["data"]),
        );
    }

}

class StoryData {
    StoryData({
        required this.user,
    });

    final User? user;

    factory StoryData.fromJson(Map<String, dynamic> json){ 
        return StoryData(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

}

class User {
    User({
        required this.name,
        required this.photoUrl,
        required this.stories,
    });

    final String? name;
    final String? photoUrl;
    final List<Story> stories;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            name: json["name"],
            photoUrl: json["photoUrl"],
            stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
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

    factory Story.fromJson(Map<String, dynamic> json){ 
        return Story(
            content: json["content"],
            text: json["text"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

}
