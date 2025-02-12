class UserModel {
  String? name;
  String? email;
  String? dob;
  String? gender;
  String? age;
  String? token;
  String? dateForRegister;
  String? time;
  String? timeStamp;
  String? status;

  UserModel({
    this.name,
    this.email,
    this.dob,
    this.gender,
    this.age,
    this.token,
    this.dateForRegister,
    this.time,
    this.timeStamp,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? " ",
        email: json['email'] ?? " ",
        dob: json['dob'] ?? " ",
        gender: json['gender'] ?? " ",
        age: json['age'] ?? " ",
        token: json['token'] ?? " ",
        dateForRegister: json['date'] ?? " ",
        time: json['time'] ?? " ",
        timeStamp: json['timeStamp'] ?? " ",
        status: json['status'] ?? 'inactive',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "dob": dob,
        "gender": gender,
        "age": age,
        "token": token,
        "date": dateForRegister,
        "time": time,
        "timeStamp": timeStamp,
        "status": status ?? 'inactive',
      };
}
