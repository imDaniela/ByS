// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Archivo {
  String url;
  String nombre;
  Archivo({
    required this.url,
    required this.nombre,
  });

  Archivo copyWith({
    String? url,
    String? nombre,
  }) {
    return Archivo(
      url: url ?? this.url,
      nombre: nombre ?? this.nombre,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'nombre': nombre,
    };
  }

  factory Archivo.fromMap(Map<String, dynamic> map) {
    return Archivo(
      url: map['url'] as String,
      nombre: map['nombre'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Archivo.fromJson(String source) =>
      Archivo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Archivo(url: $url, nombre: $nombre)';

  @override
  bool operator ==(covariant Archivo other) {
    if (identical(this, other)) return true;

    return other.url == url && other.nombre == nombre;
  }

  @override
  int get hashCode => url.hashCode ^ nombre.hashCode;
}
