import 'dart:convert';

ReactionTestModel reactionTestModelFromJson(String str) =>
    ReactionTestModel.fromJson(json.decode(str));

String reactionTestModelToJson(ReactionTestModel data) =>
    json.encode(data.toJson());

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
  String? isi0to2;
  String? isi2to4;
  String? slowingRate;
  String? performanceDecline;
  String? lpm;
  String? fpm;
  String? iqr;
  String? psr;
  String? rtrt;
  String? vigilanceIndex;
  String? alertness;
  String? resilience;
  String? fatigue;
  String? attention;
  String? cognitiveFlexibility;
  String? responseControl;
  String? cognitiveLoad;
  String? alertnessRating;
  String? supplementsTaken;
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
    this.isi0to2,
    this.isi2to4,
    this.slowingRate,
    this.performanceDecline,
    this.lpm,
    this.fpm,
    this.iqr,
    this.psr,
    this.rtrt,
    this.vigilanceIndex,
    this.alertness,
    this.resilience,
    this.fatigue,
    this.attention,
    this.cognitiveFlexibility,
    this.responseControl,
    this.cognitiveLoad,
    this.alertnessRating,
    this.supplementsTaken,
    this.reactionTest,
  });

  factory ReactionTestModel.fromJson(Map<String, dynamic> json) =>
      ReactionTestModel(
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
        isi0to2: json["isi0to2"],
        isi2to4: json["isi2to4"],
        slowingRate: json["slowingRate"],
        performanceDecline: json["performanceDecline"],
        lpm: json["lpm"],
        fpm: json["fpm"],
        iqr: json["iqr"],
        psr: json["psr"],
        rtrt: json["rtrt"],
        vigilanceIndex: json["vigilanceIndex"],
        alertness: json["alertness"],
        resilience: json["resilience"],
        fatigue: json["fatigue"],
        attention: json["attention"],
        cognitiveFlexibility: json["cognitiveFlexibility"],
        responseControl: json["responseControl"],
        cognitiveLoad: json["cognitiveLoad"],
        alertnessRating: json["alertnessRating"],
        supplementsTaken: json["supplementsTaken"],
        reactionTest: json["reactionTest"] == null
            ? []
            : List<ReactionTest>.from(
                json["reactionTest"]!.map((x) => ReactionTest.fromJson(x))),
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
        "isi0to2": isi0to2,
        "isi2to4": isi2to4,
        "slowingRate": slowingRate,
        "performanceDecline": performanceDecline,
        "lpm": lpm,
        "fpm": fpm,
        "iqr": iqr,
        "psr": psr,
        "rtrt": rtrt,
        "vigilanceIndex": vigilanceIndex,
        "alertness": alertness,
        "resilience": resilience,
        "fatigue": fatigue,
        "attention": attention,
        "cognitiveFlexibility": cognitiveFlexibility,
        "responseControl": responseControl,
        "cognitiveLoad": cognitiveLoad,
        "alertnessRating": alertnessRating,
        "supplementsTaken": supplementsTaken,
        "reactionTest": reactionTest == null
            ? []
            : List<dynamic>.from(reactionTest!.map((x) => x.toJson())),
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
        startTestTime: json["startTestTime"],
        // == null ? null : DateTime.parse(json["startTestTime"]),
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
