import 'dart:convert';

OutputHandler outputHandlerFromJson(String str) =>
    OutputHandler.fromJson(json.decode(str));

String outputHandlerToJson(OutputHandler data) => json.encode(data.toJson());

class OutputHandler {
  OutputHandler({
    required this.message,
    required this.isSuccess,
    required this.data,
    required this.status,
  });

  String message;
  bool isSuccess;
  int status;
  dynamic data;

  factory OutputHandler.fromJson(Map<String, dynamic> json) => OutputHandler(
    message: json["Message"] as String,
    isSuccess: json["IsSuccess"] as bool,
    data: json["Data"] as String,
    status: json["Status"] as int,
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "IsSuccess": isSuccess,
    "Data": data,
    "Status": status
  };
}
