// To parse this JSON data, do
//
//     final arrangementListModel = arrangementListModelFromJson(jsonString);

import 'dart:convert';

import 'arrangement_item_model/GetarrangementlistModel.dart';

ArrangementListModel arrangementListModelFromJson(String str) => ArrangementListModel.fromJson(json.decode(str));

String arrangementListModelToJson(ArrangementListModel data) => json.encode(data.toJson());

class ArrangementListModel {
  ArrangementListModel({
    this.eventid,
    this.seatingArrangements,
  });

  String? eventid;
  List<SeatingArrangement>? seatingArrangements;

  factory ArrangementListModel.fromJson(Map<String, dynamic> json) => ArrangementListModel(
    eventid: json["eventid"],
    seatingArrangements: List<SeatingArrangement>.from(json["seating_arrangements"].map((x) => SeatingArrangement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "eventid": eventid,
    "seating_arrangements": List<dynamic>.from(seatingArrangements!.map((x) => x.toJson())),
  };
}

class SeatingArrangement {
  SeatingArrangement({
    this.seatingItem,
    this.arrangements,
    this.food,
    this.foodDescription,
    this.equipment,
    this.equipmentDescription,
    this.totalCalculations,
  });

  String? seatingItem;
  List<Arrangements>? arrangements;
  String? food;
  String? foodDescription;
  bool? equipment;
  String? equipmentDescription;
  TotalCalculations? totalCalculations;
  bool isExpand = false;

  factory SeatingArrangement.fromJson(Map<String, dynamic> json) => SeatingArrangement(
    seatingItem: json["seating_item"],
    arrangements: List<Arrangements>.from(json["arrangements"].map((x) => Arrangements.fromJson(x))),
    food: json["food"],
    foodDescription: json["food_description"],
    equipment: json["equipment"],
    equipmentDescription: json["equipment_description"],
    totalCalculations: TotalCalculations.fromJson(json["totalCalculations"]),
  );

  Map<String, dynamic> toJson() => {
    "seating_item": seatingItem,
    "arrangements": List<dynamic>.from(arrangements!.map((x) => x.toJson())),
    "food": food,
    "food_description": foodDescription,
    "equipment": equipment,
    "equipment_description": equipmentDescription,
    "totalCalculations": totalCalculations!.toJson(),
  };
}

