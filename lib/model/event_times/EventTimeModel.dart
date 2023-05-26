class EventTimeModel {
  String? message;
  Data? data;
  int? status;
  bool? isSuccess;

  EventTimeModel({this.message, this.data, this.status, this.isSuccess});

  EventTimeModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    status = json['Status'];
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Status'] = this.status;
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}

class Data {
  String? sId;
  About? about;

  Data({this.sId, this.about});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    return data;
  }
}

class About {
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? aboutEvent;
  int? startTimestamp;
  int? endTimestamp;

  About(
      {this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.aboutEvent,
        this.startTimestamp,
        this.endTimestamp});

  About.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    aboutEvent = json['about_event'];
    startTimestamp = json['start_timestamp'];
    endTimestamp = json['end_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['about_event'] = this.aboutEvent;
    data['start_timestamp'] = this.startTimestamp;
    data['end_timestamp'] = this.endTimestamp;
    return data;
  }
}
