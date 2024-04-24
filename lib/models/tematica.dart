



import 'package:media_content_app/models/categoria.dart';

class Tematica {
  Tematica({
    this.nombre,
    this.categoria,
    this.permisos,
    this.uid,
  });

  String? nombre;
  Categoria? categoria;
  List<String>? permisos;
  String? uid;

  factory Tematica.fromJson(Map<String, dynamic> json) => Tematica(
        nombre: json["nombre"],
        categoria: Categoria.fromJson(json["categoria"]),
        permisos: List<String>.from(json["permisos"].map((x) => x)),
        uid: json["uid"],
      );



}
