import 'dart:convert';

ListAllEventModel listAllEventModelFromJson(String str) => ListAllEventModel.fromJson(json.decode(str));

String listAllEventModelToJson(ListAllEventModel data) => json.encode(data.toJson());

class ListAllEventModel {
  ListAllEventModel({
    required this.message,
    required this.data,
    required this.status,
    required this.isSuccess,
  });

  String message;
  Data data;
  int status;
  bool isSuccess;

  factory ListAllEventModel.fromJson(Map<String, dynamic> json) => ListAllEventModel(
    message: json["Message"],
    data: Data.fromJson(json["Data"]),
    status: json["Status"],
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Data": data.toJson(),
    "Status": status,
    "IsSuccess": isSuccess,
  };
}

class Data {
  Data({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  List<Doc> docs;
  int totalDocs;
  int limit;
  int totalPages;
  int page;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
    totalDocs: json["totalDocs"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    page: json["page"],
    pagingCounter: json["pagingCounter"],
    hasPrevPage: json["hasPrevPage"],
    hasNextPage: json["hasNextPage"],
    prevPage: json["prevPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
    "totalDocs": totalDocs,
    "limit": limit,
    "totalPages": totalPages,
    "page": page,
    "pagingCounter": pagingCounter,
    "hasPrevPage": hasPrevPage,
    "hasNextPage": hasNextPage,
    "prevPage": prevPage,
    "nextPage": nextPage,
  };
}

class Doc {
  Doc({
    required this.id,
    this.eventCategory,
    required this.name,
    required this.eventType,
    required this.other,
    required this.timestamp,
    required this.isApproved,
    required this.isLive,
    required this.status,
    required this.iseditable,
    required this.createdAt,
    required this.updatedAt,
    required this.docId,
    required this.totalAvailableSeats,
    required this.totalBookedSeats,
    required this.totalSeats,
    required this.ratings,
    required this.totalreview,
  });

  String id;
  EventCategory? eventCategory;
  String name;
  String eventType;
  String other;
  int timestamp;
  bool isApproved;
  bool isLive;
  bool status;
  bool iseditable;
  DateTime createdAt;
  DateTime updatedAt;
  String docId;
  int totalAvailableSeats;
  int totalBookedSeats;
  int totalSeats;
  String ratings;
  int totalreview;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"],
    eventCategory: json["event_category"] == null ? null : EventCategory.fromJson(json["event_category"]),
    name: json["name"],
    eventType: json["event_type"],
    other: json["other"],
    timestamp: json["timestamp"],
    isApproved: json["is_approved"],
    isLive: json["is_live"],
    status: json["status"],
    iseditable: json["iseditable"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    docId: json["id"],
    totalAvailableSeats: json["total_available_seats"],
    totalBookedSeats: json["total_booked_seats"],
    totalSeats: json["total_seats"],
    ratings: json["ratings"],
    totalreview: json["totalreview"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "event_category": eventCategory?.toJson(),
    "name": name,
    "event_type": eventType,
    "other": other,
    "timestamp": timestamp,
    "is_approved": isApproved,
    "is_live": isLive,
    "status": status,
    "iseditable": iseditable,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "id": docId,
    "total_available_seats": totalAvailableSeats,
    "total_booked_seats": totalBookedSeats,
    "total_seats": totalSeats,
    "ratings": ratings,
    "totalreview": totalreview,
  };
}

class EventCategory {
  EventCategory({
    required this.id,
    required this.categoryname,
    required this.description,
    required this.eventType,
  });

  String id;
  String categoryname;
  String description;
  String eventType;

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
    id: json["_id"],
    categoryname: json["categoryname"],
    description: json["description"],
    eventType: json["event_type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryname": categoryname,
    "description": description,
    "event_type": eventType,
  };
}
