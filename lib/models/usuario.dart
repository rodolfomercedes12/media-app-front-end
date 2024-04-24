
import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.roll,
    this.username,
    this.email,
    this.uid,
  });

  String? roll;
  String? username;
  String? email;
  String? uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        roll: json["roll"],
        username: json["username"],
        email: json["email"],
        uid: json["uid"],
      );


  Map<String, dynamic> toJson() => {
        "username": username,
        "roll": roll,
        "email": email,
        "uid": uid,
      };
}
