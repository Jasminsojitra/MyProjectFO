// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

MediaModel mediaModelFromJson(String str) => MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  String? eventid;
  String? banner;
  List<Photo>? photos;
  List<Video>? videos;

  MediaModel({
    this.eventid,
    this.banner,
    this.photos,
    this.videos,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
    eventid: json["_id"],
    banner: json["banner"],
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eventid": eventid,
    "banner": banner,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class Photo {
  String? url;
  String? description;

  Photo({
    this.url,
    this.description,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    url: json["url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "description": description,
  };
}

class Video {
  String? url;
  String? thumbnail;
  String? description;

  Video({
    this.url,
    this.thumbnail,
    this.description,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    url: json["url"],
    thumbnail: json["thumbnail"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "thumbnail": thumbnail,
    "description": description,
  };
}



MediaRespoModel mediaRespoModelFromJson(String str) => MediaRespoModel.fromJson(json.decode(str));

String mediaRespoModelToJson(MediaRespoModel data) => json.encode(data.toJson());

class MediaRespoModel {
  String? message;
  Data? data;
  int? status;
  bool? isSuccess;

  MediaRespoModel({
    this.message,
    this.data,
    this.status,
    this.isSuccess,
  });

  factory MediaRespoModel.fromJson(Map<String, dynamic> json) => MediaRespoModel(
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
    status: json["Status"],
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Data": data?.toJson(),
    "Status": status,
    "IsSuccess": isSuccess,
  };
}

class Data {
  String? id;
  String? banner;
  List<Photo>? photos;
  List<Video>? videos;

  Data({
    this.id,
    this.banner,
    this.photos,
    this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    banner: json["banner"],
    photos: json["photos"] == null ? [] : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "banner": banner,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}


