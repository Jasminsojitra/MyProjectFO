class LocationModel {
  String? message;
  Data? data;
  int? status;
  bool? isSuccess;

  LocationModel({this.message, this.data, this.status, this.isSuccess});

  LocationModel.fromJson(Map<String, dynamic> json) {
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
  EventLocation? eventLocation;

  Data({this.sId, this.eventLocation});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventLocation = json['event_location'] != null
        ? new EventLocation.fromJson(json['event_location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.eventLocation != null) {
      data['event_location'] = this.eventLocation!.toJson();
    }
    return data;
  }
}

class EventLocation {
  Location? location;
  String? flatNo;
  String? streetName;
  String? areaName;
  String? city;
  String? state;
  String? pincode;
  String? manualAddress;

  EventLocation(
      {this.location,
        this.flatNo,
        this.streetName,
        this.areaName,
        this.city,
        this.state,
        this.pincode,
        this.manualAddress});

  EventLocation.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    flatNo = json['flat_no'];
    streetName = json['street_name'];
    areaName = json['area_name'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    manualAddress = json['manual_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['flat_no'] = this.flatNo;
    data['street_name'] = this.streetName;
    data['area_name'] = this.areaName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['manual_address'] = this.manualAddress;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}