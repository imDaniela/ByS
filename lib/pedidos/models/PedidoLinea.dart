// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PedidoLinea {
  String codart;
  String? nombre;
  int cantidad;
  double precio;
  double? descuento;
  int sto;
  bool envase;
  PedidoLinea(
      {required this.codart,
      this.nombre,
      required this.cantidad,
      required this.precio,
      this.descuento,
      this.sto = 0,
      this.envase = false});

  PedidoLinea copyWith(
      {String? codart,
      String? nombre,
      int? cantidad,
      double? precio,
      double? descuento,
      int? sto,
      bool? envase}) {
    return PedidoLinea(
        codart: codart ?? this.codart,
        nombre: nombre ?? this.nombre,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
        descuento: descuento ?? this.descuento,
        sto: sto ?? this.sto,
        envase: envase ?? this.envase);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codart': codart,
      'nombre': nombre,
      'cantidad': cantidad,
      'precio': precio,
      'descuento': descuento,
      'sto': sto,
      'envase': envase,
    };
  }

  factory PedidoLinea.fromMap(Map<String, dynamic> map) {
    return PedidoLinea(
        codart: map['codart'].toString(),
        nombre: map['nombre'] != null ? map['nombre'] as String : null,
        cantidad: map['cantidad'] as int,
        precio: double.tryParse(map['precio'].toString()) ?? 0.00,
        descuento: map['descuento'] != null
            ? double.tryParse(map['descuento'].toString())
            : null,
        sto: map['sto'] != null ? map['sto'] as int : 0,
        envase: map['envase']);
  }

  String toJson() => json.encode(toMap());

  factory PedidoLinea.fromJson(String source) =>
      PedidoLinea.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PedidoLinea(codart: $codart, nombre: $nombre, cantidad: $cantidad, precio: $precio, descuento: $descuento,stock: ${sto})';
  }

  @override
  bool operator ==(covariant PedidoLinea other) {
    if (identical(this, other)) return true;

    return other.codart == codart &&
        other.nombre == nombre &&
        other.cantidad == cantidad &&
        other.precio == precio &&
        other.descuento == descuento &&
        other.sto == sto;
  }

  @override
  int get hashCode {
    return codart.hashCode ^
        nombre.hashCode ^
        cantidad.hashCode ^
        precio.hashCode ^
        descuento.hashCode ^
        sto.hashCode;
  }
}
