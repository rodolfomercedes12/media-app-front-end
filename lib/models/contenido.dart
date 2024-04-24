


import 'package:media_content_app/models/tematica.dart';
import 'package:media_content_app/models/usuario.dart';



class Contenido {
  Contenido({
    this.titulo,
    this.creador,
    this.tematica,
    this.uid,
    this.urlImagen
  });

  String? titulo;
  Usuario? creador;
  Tematica? tematica;
  String? urlImagen;
  String? uid;

  factory Contenido.fromJson(Map<String, dynamic> json) => Contenido(
        titulo: json["titulo"],
        urlImagen: json["urlImagen"],
        creador: Usuario.fromJson(json["creador"]),
        tematica: Tematica.fromJson(json["tematica"]),
        uid: json["uid"],
      );


 /* Map<String, dynamic> toJson() => {
        "username": username,
        "roll": roll,
        "email": email,
        "uid": uid,
      };*/
}
