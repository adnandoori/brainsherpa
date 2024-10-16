class ReactionTestModel {
  String? startTestTime;
  String? startTimeForGreenCard;
  String? tapTimeForGreenCard;
  String? isTap;

  ReactionTestModel({
    this.startTestTime,
    this.startTimeForGreenCard,
    this.tapTimeForGreenCard,
    this.isTap,
  });

  factory ReactionTestModel.fromJson(Map<String, dynamic> json) =>
      ReactionTestModel(
        startTestTime: json['startTestTime'] ?? " ",
        startTimeForGreenCard: json['startTimeForGreenCard'] ?? " ",
        tapTimeForGreenCard: json['tapTimeForGreenCard'] ?? " ",
        isTap: json['isTap'] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "startTestTime": startTestTime,
        "startTimeForGreenCard": startTimeForGreenCard,
        "tapTimeForGreenCard": tapTimeForGreenCard,
        "isTap": isTap,
      };
}
