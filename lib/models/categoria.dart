

class Categoria {
  final String nombre;
  final String urlImagen;
  final String uid;

  Categoria({
    required this.nombre,
    required this.urlImagen,
    required this.uid,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nombre: json['nombre'],
      urlImagen: json['urlImagen'],
      uid: json['_id'] ?? json["uid"],
    );
  }
}