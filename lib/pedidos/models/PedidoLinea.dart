// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PedidoLinea {
  int codart;
  String? nombre;
  int cantidad;
  double precio;
  double? descuento;
  PedidoLinea({
    required this.codart,
    this.nombre,
    required this.cantidad,
    required this.precio,
    this.descuento,
  });

  PedidoLinea copyWith({
    int? codart,
    String? nombre,
    int? cantidad,
    double? precio,
    double? descuento,
  }) {
    return PedidoLinea(
      codart: codart ?? this.codart,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      precio: precio ?? this.precio,
      descuento: descuento ?? this.descuento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codart': codart,
      'nombre': nombre,
      'cantidad': cantidad,
      'precio': precio,
      'descuento': descuento,
    };
  }

  factory PedidoLinea.fromMap(Map<String, dynamic> map) {
    return PedidoLinea(
      codart: map['codart'] as int,
      nombre: map['nombre'] != null ? map['nombre'] as String : null,
      cantidad: map['cantidad'] as int,
      precio: map['precio'] as double,
      descuento: map['descuento'] != null ? map['descuento'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoLinea.fromJson(String source) =>
      PedidoLinea.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PedidoLinea(codart: $codart, nombre: $nombre, cantidad: $cantidad, precio: $precio, descuento: $descuento)';
  }

  @override
  bool operator ==(covariant PedidoLinea other) {
    if (identical(this, other)) return true;

    return other.codart == codart &&
        other.nombre == nombre &&
        other.cantidad == cantidad &&
        other.precio == precio &&
        other.descuento == descuento;
  }

  @override
  int get hashCode {
    return codart.hashCode ^
        nombre.hashCode ^
        cantidad.hashCode ^
        precio.hashCode ^
        descuento.hashCode;
  }
}
