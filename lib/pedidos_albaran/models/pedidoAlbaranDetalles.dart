// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PedidoAlbaranDetalles {

  final int? numeroAlbaran;
  final String? codigoArticulo;
  final String? descripcion;
  final int? cantidadArticulo;
  final double? precioVenta;
  final double? subtotal;
  final String? fechaCreacion;
  PedidoAlbaranDetalles({
    this.numeroAlbaran,
    this.codigoArticulo,
    this.descripcion,
    this.cantidadArticulo,
    this.precioVenta,
    this.subtotal,
    this.fechaCreacion,
  });


  PedidoAlbaranDetalles copyWith({
    int? numeroAlbaran,
    String? codigoArticulo,
    String? descripcion,
    int? cantidadArticulo,
    double? precioVenta,
    double? subtotal,
    String? fechaCreacion,
  }) {
    return PedidoAlbaranDetalles(
      numeroAlbaran: numeroAlbaran ?? this.numeroAlbaran,
      codigoArticulo: codigoArticulo ?? this.codigoArticulo,
      descripcion: descripcion ?? this.descripcion,
      cantidadArticulo: cantidadArticulo ?? this.cantidadArticulo,
      precioVenta: precioVenta ?? this.precioVenta,
      subtotal: subtotal ?? this.subtotal,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'NUMALB': numeroAlbaran,
      'CODART': codigoArticulo,
      'DES': descripcion,
      'CANSER': cantidadArticulo,
      'PREVEN': precioVenta,
      'SUBTOT': subtotal,
      'FECGAR': fechaCreacion,
    };
  }

  factory PedidoAlbaranDetalles.fromMap(Map<String, dynamic> map) {
    return PedidoAlbaranDetalles(
      numeroAlbaran: map['NUMALB'] != null ? map['NUMALB'] as int : null,
      codigoArticulo: map['CODART'] != null ? map['CODART'] as String : null,
      descripcion: map['DES'] != null ? map['DES'] as String : null,
      cantidadArticulo: map['CANSER'] != null ? map['CANSER'] as int : null,
      precioVenta: map['PREVEN']?.toDouble(),
      subtotal: map['SUBTOT']?.toDouble(),
      fechaCreacion: map['FECGAR'] != null ? map['FECGAR'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoAlbaranDetalles.fromJson(String source) => PedidoAlbaranDetalles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PedidoAlbaranDetalles(numeroAlbaran: $numeroAlbaran, codigoArticulo: $codigoArticulo, descripcion: $descripcion, cantidadArticulo: $cantidadArticulo, precioVenta: $precioVenta, subtotal: $subtotal, fechaCreacion: $fechaCreacion)';
  }

  @override
  bool operator ==(covariant PedidoAlbaranDetalles other) {
    if (identical(this, other)) return true;
  
    return 
      other.numeroAlbaran == numeroAlbaran &&
      other.codigoArticulo == codigoArticulo &&
      other.descripcion == descripcion &&
      other.cantidadArticulo == cantidadArticulo &&
      other.precioVenta == precioVenta &&
      other.subtotal == subtotal &&
      other.fechaCreacion == fechaCreacion;
  }

  @override
  int get hashCode {
    return numeroAlbaran.hashCode ^
      codigoArticulo.hashCode ^
      descripcion.hashCode ^
      cantidadArticulo.hashCode ^
      precioVenta.hashCode ^
      subtotal.hashCode ^
      fechaCreacion.hashCode;
  }
}
