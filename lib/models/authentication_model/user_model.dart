class UserModel {
  String? name;
  String? email;
  String? token;
  String? dateForRegister;
  String? time;
  String? timeStamp;

  UserModel({
    this.name,
    this.email,
    this.token,
    this.dateForRegister,
    this.time,
    this.timeStamp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? " ",
        email: json['email'] ?? " ",
        token: json['token'] ?? " ",
        dateForRegister: json['date'] ?? " ",
        time: json['time'] ?? " ",
        timeStamp: json['timeStamp'] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "token": token,
        "date": dateForRegister,
        "time": time,
        "timeStamp": timeStamp
      };
}
