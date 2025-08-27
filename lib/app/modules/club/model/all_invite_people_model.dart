class AllInvitePeopleModel {
    AllInvitePeopleModel({
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
    final Data? data;

    factory AllInvitePeopleModel.fromJson(Map<String, dynamic> json){ 
        return AllInvitePeopleModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.club,
        required this.inviteList,
    });

    final Club? club;
    final List<InviteList> inviteList;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            club: json["club"] == null ? null : Club.fromJson(json["club"]),
            inviteList: json["inviteList"] == null ? [] : List<InviteList>.from(json["inviteList"]!.map((x) => InviteList.fromJson(x))),
        );
    }

}

class Club {
    Club({
        required this.id,
        required this.name,
        required this.owner,
    });

    final String? id;
    final String? name;
    final InviteList? owner;

    factory Club.fromJson(Map<String, dynamic> json){ 
        return Club(
            id: json["_id"],
            name: json["name"],
            owner: json["owner"] == null ? null : InviteList.fromJson(json["owner"]),
        );
    }

}

class InviteList {
    InviteList({
        required this.id,
        required this.name,
        required this.photoUrl,
        required this.email,
    });

    final String? id;
    final String? name;
    final String? photoUrl;
    final String? email;

    factory InviteList.fromJson(Map<String, dynamic> json){ 
        return InviteList(
            id: json["_id"],
            name: json["name"],
            photoUrl: json["photoUrl"],
            email: json["email"],
        );
    }

}

class Meta {
    Meta({
        required this.page,
        required this.limit,
        required this.total,
        required this.totalPages,
    });

    final int? page;
    final int? limit;
    final int? total;
    final int? totalPages;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            page: json["page"],
            limit: json["limit"],
            total: json["total"],
            totalPages: json["totalPages"],
        );
    }

}
