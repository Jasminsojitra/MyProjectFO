import 'dart:convert';

PermissionLatterRespo permissionLatterRespoFromJson(String str) => PermissionLatterRespo.fromJson(json.decode(str));

String permissionLatterRespoToJson(PermissionLatterRespo data) => json.encode(data.toJson());

class PermissionLatterRespo {
  String? message;
  Data? data;
  int? status;
  bool? isSuccess;

  PermissionLatterRespo({
    this.message,
    this.data,
    this.status,
    this.isSuccess,
  });

  factory PermissionLatterRespo.fromJson(Map<String, dynamic> json) => PermissionLatterRespo(
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
  bool? acceptBooking;
  String? permissionLetter;

  Data({
    this.id,
    this.acceptBooking,
    this.permissionLetter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    acceptBooking: json["accept_booking"],
    permissionLetter: json["permission_letter"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accept_booking": acceptBooking,
    "permission_letter": permissionLetter,
  };
}
