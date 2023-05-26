
class GetarrangementlistModel {
  String? message;
  Data? data;
  int? status;
  bool? isSuccess;

  GetarrangementlistModel(
      {this.message, this.data, this.status, this.isSuccess});

  GetarrangementlistModel.fromJson(Map<String, dynamic> json) {
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
  List<SeatingArrangements>? seatingArrangements;

  Data({this.sId, this.seatingArrangements});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['seating_arrangements'] != null) {
      seatingArrangements = <SeatingArrangements>[];
      json['seating_arrangements'].forEach((v) {
        seatingArrangements!.add(new SeatingArrangements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.seatingArrangements != null) {
      data['seating_arrangements'] =
          this.seatingArrangements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SeatingArrangements {
  SeatingItem? seatingItem;
  List<Arrangements>? arrangements;
  String? food;
  String? foodDescription;
  bool? equipment;
  String? equipmentDescription;
  TotalCalculations? totalCalculations;
  bool isExpand=false;

  SeatingArrangements(
      {this.seatingItem,
        this.arrangements,
        this.food,
        this.foodDescription,
        this.equipment,
        this.equipmentDescription,
        this.totalCalculations,
      this.isExpand=false});

  SeatingArrangements.fromJson(Map<String, dynamic> json) {
    seatingItem = json['seating_item'] != null
        ? new SeatingItem.fromJson(json['seating_item'])
        : null;
    if (json['arrangements'] != null) {
      arrangements = <Arrangements>[];
      json['arrangements'].forEach((v) {
        arrangements!.add(new Arrangements.fromJson(v));
      });
    }
    food = json['food'];
    foodDescription = json['food_description'];
    equipment = json['equipment'];
    equipmentDescription = json['equipment_description'];
    isExpand=false;
    totalCalculations = json['totalCalculations'] != null
        ? new TotalCalculations.fromJson(json['totalCalculations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seatingItem != null) {
      data['seating_item'] = this.seatingItem!.toJson();
    }
    if (this.arrangements != null) {
      data['arrangements'] = this.arrangements!.map((v) => v.toJson()).toList();
    }
    data['food'] = this.food;
    data['food_description'] = this.foodDescription;
    data['equipment'] = this.equipment;
    data['equipment_description'] = this.equipmentDescription;
    if (this.totalCalculations != null) {
      data['totalCalculations'] = this.totalCalculations!.toJson();
    }
    return data;
  }
}

class SeatingItem {
  String? sId;
  String? itemname;
  String? itemimage;
  String? description;
  bool? isonlyperperson;

  SeatingItem(
      {this.sId,
        this.itemname,
        this.itemimage,
        this.description,
        this.isonlyperperson});

  SeatingItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemname = json['itemname'];
    itemimage = json['itemimage'];
    description = json['description'];
    isonlyperperson = json['isonlyperperson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemname'] = this.itemname;
    data['itemimage'] = this.itemimage;
    data['description'] = this.description;
    data['isonlyperperson'] = this.isonlyperperson;
    return data;
  }
}

class Arrangements {
  int? numberOfSeatingItem;
  String? verticalLocation;
  String? horizontalLocation;
  int? perSeatingPerson;
  int? totalPerson;
  double? perSeatingPrice;
  double? perPersonPrice;
  double? totalAmount;
  String? description;
  bool? bookingAcceptance;
  String? icon;
  int? totalAvailableSeats;
  int? totalSeats;
  int? totalBooked;
  bool isExpand = false;

  Arrangements(
      {this.numberOfSeatingItem,
        this.verticalLocation,
        this.horizontalLocation,
        this.perSeatingPerson,
        this.totalPerson,
        this.perSeatingPrice,
        this.perPersonPrice,
        this.totalAmount,
        this.description,
        this.bookingAcceptance,
        this.icon,
        this.totalAvailableSeats,
        this.totalSeats,
        this.totalBooked});

  Arrangements.fromJson(Map<String, dynamic> json) {
    numberOfSeatingItem = json['number_of_seating_item'];
    verticalLocation = json['vertical_location'];
    horizontalLocation = json['horizontal_location'];
    perSeatingPerson = json['per_seating_person'];
    totalPerson = json['total_person'];
    perSeatingPrice = (json['per_seating_price']??0).toDouble();
    perPersonPrice = (json['per_person_price']??0).toDouble();
    totalAmount = (json['total_amount']??0).toDouble();
    description = json['description'];
    bookingAcceptance = json['booking_acceptance'];
    icon = json['icon'];
    totalAvailableSeats = json['total_available_seats'];
    totalSeats = json['total_seats'];
    totalBooked = json['total_booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_seating_item'] = this.numberOfSeatingItem;
    data['vertical_location'] = this.verticalLocation;
    data['horizontal_location'] = this.horizontalLocation;
    data['per_seating_person'] = this.perSeatingPerson;
    data['total_person'] = this.totalPerson;
    data['per_seating_price'] = this.perSeatingPrice;
    data['per_person_price'] = this.perPersonPrice;
    data['total_amount'] = this.totalAmount;
    data['description'] = this.description;
    data['booking_acceptance'] = this.bookingAcceptance;
    data['icon'] = this.icon;
    data['total_available_seats'] = this.totalAvailableSeats;
    data['total_seats'] = this.totalSeats;
    data['total_booked'] = this.totalBooked;
    return data;
  }
}

class TotalCalculations {
  int? totalNumberOfSeatingItems;
  int? totalPerSeatingPersons;
  int? totalPersons;
  double? perSeatingPrice;
  double? perPersonPrice;
  double? totalAmount;
  int? totalBooked;

  TotalCalculations(
      {this.totalNumberOfSeatingItems,
        this.totalPerSeatingPersons,
        this.totalPersons,
        this.perSeatingPrice,
        this.perPersonPrice,
        this.totalAmount,
        this.totalBooked});

  TotalCalculations.fromJson(Map<String, dynamic> json) {
    totalNumberOfSeatingItems = json['total_number_of_seating_items'];
    totalPerSeatingPersons = json['total_per_seating_persons'];
    totalPersons = json['total_persons'];
    perSeatingPrice = json['per_seating_price'].toDouble();
    perPersonPrice = json['per_person_price'].toDouble();
    totalAmount = json['total_amount'].toDouble();
    totalBooked = json['total_booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_number_of_seating_items'] = this.totalNumberOfSeatingItems;
    data['total_per_seating_persons'] = this.totalPerSeatingPersons;
    data['total_persons'] = this.totalPersons;
    data['per_seating_price'] = this.perSeatingPrice;
    data['per_person_price'] = this.perPersonPrice;
    data['total_amount'] = this.totalAmount;
    data['total_booked'] = this.totalBooked;
    return data;
  }
}