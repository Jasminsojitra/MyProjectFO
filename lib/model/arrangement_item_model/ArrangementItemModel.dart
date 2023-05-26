class ArrangementItemModel {
  String? message;
  List<Data>? data;
  int? status;
  bool? isSuccess;

  ArrangementItemModel({this.message, this.data, this.status, this.isSuccess});

  ArrangementItemModel.fromJson(Map<String, dynamic> json) {
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
  String? itemname;
  String? itemimage;
  String? description;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool isSelected = false;

  Data(
      {this.sId,
        this.createdBy,
        this.updatedBy,
        this.itemname,
        this.itemimage,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV,
        required this.isSelected});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    itemname = json['itemname'];
    itemimage = json['itemimage'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    // isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['itemname'] = this.itemname;
    data['itemimage'] = this.itemimage;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    // data['isSelected'] = this.isSelected;
    return data;
  }
}
