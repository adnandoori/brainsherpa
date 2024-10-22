
// To parse this JSON data, do
//
//     final reactionTestModel = reactionTestModelFromJson(jsonString);

import 'dart:convert';

ReactionTestModel reactionTestModelFromJson(String str) => ReactionTestModel.fromJson(json.decode(str));

String reactionTestModelToJson(ReactionTestModel data) => json.encode(data.toJson());

class ReactionTestModel {
  String? userId;
  String? average;
  String? fastest;
  String? slowest;
  String? speed;
  String? falseStart;
  String? accuracy;
  String? variation;
  String? plusLapses;
  String? dateTime;
  String? monthYear;
  String? reactionTestTime;
  int? timeStamp;
  List<ReactionTest>? reactionTest;

  ReactionTestModel({
    this.userId,
    this.average,
    this.fastest,
    this.slowest,
    this.speed,
    this.falseStart,
    this.accuracy,
    this.variation,
    this.plusLapses,
    this.dateTime,
    this.monthYear,
    this.reactionTestTime,
    this.timeStamp,
    this.reactionTest,
  });

  factory ReactionTestModel.fromJson(Map<String, dynamic> json) => ReactionTestModel(
    userId: json["userId"],
    average: json["average"],
    fastest: json["fastest"],
    slowest: json["slowest"],
    speed: json["speed"],
    falseStart: json["falseStart"],
    accuracy: json["accuracy"],
    variation: json["variation"],
    plusLapses: json["plusLapses"],
    dateTime: json["dateTime"],
    monthYear: json["monthYear"],
    reactionTestTime: json["reactionTestTime"],
    timeStamp: json["timeStamp"],
    reactionTest: json["reactionTest"] == null ? [] : List<ReactionTest>.from(json["reactionTest"]!.map((x) => ReactionTest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "average": average,
    "fastest": fastest,
    "slowest": slowest,
    "speed": speed,
    "falseStart": falseStart,
    "accuracy": accuracy,
    "variation": variation,
    "plusLapses": plusLapses,
    "dateTime": dateTime,
    "monthYear": monthYear,
    "reactionTestTime": reactionTestTime,
    "timeStamp": timeStamp,
    "reactionTest": reactionTest == null ? [] : List<dynamic>.from(reactionTest!.map((x) => x.toJson())),
  };
}

class ReactionTest {
  String? startTestTime;
  String? startTimeForGreenCard;
  String? tapTimeForGreenCard;
  String? isTap;
  int? randomTime;

  ReactionTest({
    this.startTestTime,
    this.startTimeForGreenCard,
    this.tapTimeForGreenCard,
    this.isTap,
    this.randomTime,
  });

  factory ReactionTest.fromJson(Map<String, dynamic> json) => ReactionTest(
    startTestTime: json["startTestTime"], // == null ? null : DateTime.parse(json["startTestTime"]),
    startTimeForGreenCard: json["startTimeForGreenCard"],
    tapTimeForGreenCard: json["tapTimeForGreenCard"],
    isTap: json["isTap"],
    randomTime: json["randomTime"],
  );

  Map<String, dynamic> toJson() => {
    "startTestTime": startTestTime,
    "startTimeForGreenCard": startTimeForGreenCard,
    "tapTimeForGreenCard": tapTimeForGreenCard,
    "isTap": isTap,
    "randomTime": randomTime,
  };
}


// class ReactionTestModel
// {
//   String? userId;
//   String? average;
//   String? fastest;
//   String? slowest;
//   String? speed;
//   String? falseStart;
//   String? accuracy;
//   String? variation;
//   String? plusLapses;
//   String? dateTime;
//   String? monthYear;
//   String? reactionTestTime;
//   int? timeStamp;
//   List<ReactionTest>? reactionTest;
//
//   ReactionTestModel({
//     this.userId,
//     this.average,
//     this.fastest,
//     this.slowest,
//     this.speed,
//     this.falseStart,
//     this.accuracy,
//     this.variation,
//     this.plusLapses,
//     this.dateTime,
//     this.monthYear,
//     this.reactionTestTime,
//     this.timeStamp,
//     this.reactionTest,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'average': average,
//       'fastest': fastest,
//       'slowest': slowest,
//       'speed': speed,
//       'falseStart': falseStart,
//       'accuracy': accuracy,
//       'variation': variation,
//       'plusLapses': plusLapses,
//       'dateTime': dateTime,
//       'monthYear': monthYear,
//       'reactionTestTime': reactionTestTime,
//       'timeStamp': timeStamp,
//       'reactionTest': reactionTest?.map((rt) => rt.toJson()).toList(),
//     };
//   }
//
//   factory ReactionTestModel.fromMap(Map<String, dynamic> map) {
//     return ReactionTestModel(
//       userId: map['userId'],
//       average: map['average'],
//       fastest: map['fastest'],
//       slowest: map['slowest'],
//       speed: map['speed'],
//       falseStart: map['falseStart'],
//       accuracy: map['accuracy'],
//       variation: map['variation'],
//       plusLapses: map['plusLapses'],
//       dateTime: map['dateTime'],
//       monthYear: map['monthYear'],
//       reactionTestTime: map['reactionTestTime'],
//       timeStamp: map['timeStamp'],
//       reactionTest: (map['reactionTest'] as List<dynamic>)
//           .map((rt) => ReactionTest.fromJson(rt))
//           .toList(),
//     );
//   }
// }
//
// class ReactionTest {
//   String? startTestTime;
//   String? startTimeForGreenCard;
//   String? tapTimeForGreenCard;
//   String? isTap;
//   int? randomTime;
//
//   ReactionTest({
//     this.startTestTime,
//     this.startTimeForGreenCard,
//     this.tapTimeForGreenCard,
//     this.isTap,
//     this.randomTime,
//   });
//
//   factory ReactionTest.fromJson(Map<String, dynamic> json) => ReactionTest(
//         startTestTime: json['startTestTime'] ?? " ",
//         startTimeForGreenCard: json['startTimeForGreenCard'] ?? " ",
//         tapTimeForGreenCard: json['tapTimeForGreenCard'] ?? " ",
//         randomTime: json['randomTime'] ?? 0,
//         isTap: json['isTap'] ?? " ",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "startTestTime": startTestTime,
//         "startTimeForGreenCard": startTimeForGreenCard,
//         "tapTimeForGreenCard": tapTimeForGreenCard,
//         "isTap": isTap,
//         "randomTime": randomTime,
//       };
// }

