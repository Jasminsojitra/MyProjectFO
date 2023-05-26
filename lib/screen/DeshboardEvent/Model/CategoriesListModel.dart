class CategoriesListModel {
  String? message;
  List<Data>? data;
  int? status;
  bool? isSuccess;

  CategoriesListModel({this.message, this.data, this.status, this.isSuccess});

  CategoriesListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['Status'];
    isSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['IsSuccess'] = this.isSuccess;
    return data;
  }
}

class Data {
  String? sId;
  String? createdBy;
  String? updatedBy;
  String? categoryname;
  String? description;
  String? eventType;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isSelected;

  Data(
      {this.sId,
        this.createdBy,
        this.updatedBy,
        this.categoryname,
        this.description,
        this.eventType,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isSelected=false});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    categoryname = json['categoryname'];
    description = json['description'];
    eventType = json['event_type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['categoryname'] = this.categoryname;
    data['description'] = this.description;
    data['event_type'] = this.eventType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
