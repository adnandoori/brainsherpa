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
  String? performanceScore;
  String? successRate;
  String? deltaSF;
  String? lapseProbability;
  String? miniLapse;
  String? plusLapse;
  String? sLapse;
  String? deltaIsi;
  String? falseStartIsi0to2;
  String? falseStartIsi2to4;
  String? plusLapseIsi0to2;
  String? plusLapseIsi2to4;
  String? averageFirstMin;
  String? averageSecondMin;
  String? averageThirdMin;
  String? notes;
  String? trendInsight;
  double? resilienceScore;
  double? flexibilityScore;
  double? focusScore;

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
    this.performanceScore,
    this.successRate,
    this.deltaSF,
    this.lapseProbability,
    this.miniLapse,
    this.plusLapse,
    this.sLapse,
    this.deltaIsi,
    this.falseStartIsi0to2,
    this.falseStartIsi2to4,
    this.plusLapseIsi0to2,
    this.plusLapseIsi2to4,
    this.averageFirstMin,
    this.averageSecondMin,
    this.averageThirdMin,
    this.notes,
    this.reactionTest,
    this.trendInsight,
    this.resilienceScore,
    this.flexibilityScore,
    this.focusScore,
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
        performanceScore: json["performanceScore"],
        successRate: json["successRate"],
        deltaSF: json["deltaSF"],
        lapseProbability: json["lapseProbability"],
        miniLapse: json["miniLapse"],
        plusLapse: json["plusLapse"],
        sLapse: json["sLapse"],
        deltaIsi: json["deltaIsi"],
        falseStartIsi0to2: json["falseStartIsi0to2"],
        falseStartIsi2to4: json["falseStartIsi2to4"],
        plusLapseIsi0to2: json["plusLapseIsi0to2"],
        plusLapseIsi2to4: json["plusLapseIsi2to4"],
        averageFirstMin: json["averageFirstMin"],
        averageSecondMin: json["averageSecondMin"],
        averageThirdMin: json["averageThirdMin"],
        notes: json["notes"],
        trendInsight: json["trendInsight"],
        resilienceScore: json["resilienceScore"],
        flexibilityScore: json["flexibilityScore"],
        focusScore: json["focusScore"],
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
        "performanceScore": performanceScore,
        "successRate": successRate,
        "deltaSF": deltaSF,
        "lapseProbability": lapseProbability,
        "miniLapse": miniLapse,
        "plusLapse": plusLapse,
        "sLapse": sLapse,
        "deltaIsi": deltaIsi,
        "falseStartIsi0to2": falseStartIsi0to2,
        "falseStartIsi2to4": falseStartIsi2to4,
        "plusLapseIsi0to2": plusLapseIsi0to2,
        "plusLapseIsi2to4": plusLapseIsi2to4,
        "averageFirstMin": averageFirstMin,
        "averageSecondMin": averageSecondMin,
        "averageThirdMin": averageThirdMin,
        "notes": notes,
        "trendInsight": trendInsight,
        "resilienceScore": resilienceScore,
        "flexibilityScore": flexibilityScore,
        "focusScore": focusScore,
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
  int? reactionTime;
  int? randomTimeIsi;
  int? epTime;

  ReactionTest({
    this.startTestTime,
    this.startTimeForGreenCard,
    this.tapTimeForGreenCard,
    this.isTap,
    this.randomTime,
    this.reactionTime,
    this.randomTimeIsi,
    this.epTime,
  });

  factory ReactionTest.fromJson(Map<String, dynamic> json) => ReactionTest(
        startTestTime: json["startTestTime"],
        // == null ? null : DateTime.parse(json["startTestTime"]),
        startTimeForGreenCard: json["startTimeForGreenCard"],
        tapTimeForGreenCard: json["tapTimeForGreenCard"],
        isTap: json["isTap"],
        randomTime: json["randomTime"],
        reactionTime: json["reactionTime"],
        randomTimeIsi: json["randomTimeIsi"],
        epTime: json["eptime"],
      );

  Map<String, dynamic> toJson() => {
        "startTestTime": startTestTime,
        "startTimeForGreenCard": startTimeForGreenCard,
        "tapTimeForGreenCard": tapTimeForGreenCard,
        "isTap": isTap,
        "randomTime": randomTime,
        "reactionTime": reactionTime,
        "randomTimeIsi": randomTimeIsi,
        "eptime": epTime,
      };
}
