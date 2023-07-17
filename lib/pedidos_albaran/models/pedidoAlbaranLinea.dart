// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PedidoAlbaranLinea {

  final int? numeroAlbaran;
  final String? fechaCreacion;
  final int? codigoMovistar;
  final String? nombreComercial;
  final int? codigoCliente;
  final String? nombreFiscal;
  PedidoAlbaranLinea({
    this.numeroAlbaran,
    this.fechaCreacion,
    this.codigoMovistar,
    this.nombreComercial,
    this.codigoCliente,
    this.nombreFiscal,
  });



  PedidoAlbaranLinea copyWith({
    int? numeroAlbaran,
    String? fechaCreacion,
    int? codigoMovistar,
    String? nombreComercial,
    int? codigoCliente,
    String? nombreFiscal,
  }) {
    return PedidoAlbaranLinea(
      numeroAlbaran: numeroAlbaran ?? this.numeroAlbaran,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      codigoMovistar: codigoMovistar ?? this.codigoMovistar,
      nombreComercial: nombreComercial ?? this.nombreComercial,
      codigoCliente: codigoCliente ?? this.codigoCliente,
      nombreFiscal: nombreFiscal ?? this.nombreFiscal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'NUMALB': numeroAlbaran,
      'FECGAR': fechaCreacion,
      'IDMOVISTAR': codigoMovistar,
      'cliente': {
        'CODCLI': codigoCliente,
        'nom': nombreComercial,
        'cal2': nombreFiscal
      },
    };
  }

  factory PedidoAlbaranLinea.fromMap(Map<String, dynamic> map) {
    final clientMap = map['cliente'];
    return PedidoAlbaranLinea(
      numeroAlbaran: map['NUMALB'] != null ? map['NUMALB'] as int : null,
      fechaCreacion: map['FECGAR'] != null ? map['FECGAR'] as String : null,
      codigoMovistar: map['IDMOVISTAR'] != null ? map['IDMOVISTAR'] as int : null,
      nombreComercial: clientMap['nom'] != null ? clientMap['nom'] as String : null,
      codigoCliente: clientMap['CODCLI'] != null ? clientMap['CODCLI'] as int : null,
      nombreFiscal: clientMap['cal2'] != null ? clientMap['cal2'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoAlbaranLinea.fromJson(String source) => PedidoAlbaranLinea.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PedidoAlbaranLinea(numeroAlbaran: $numeroAlbaran, fechaCreacion: $fechaCreacion, codigoMovistar: $codigoMovistar, nombreComercial: $nombreComercial, codigoCliente: $codigoCliente, nombreFiscal: $nombreFiscal)';
  }

  @override
  bool operator ==(covariant PedidoAlbaranLinea other) {
    if (identical(this, other)) return true;
  
    return 
      other.numeroAlbaran == numeroAlbaran &&
      other.fechaCreacion == fechaCreacion &&
      other.codigoMovistar == codigoMovistar &&
      other.nombreComercial == nombreComercial &&
      other.codigoCliente == codigoCliente &&
      other.nombreFiscal == nombreFiscal;
  }

  @override
  int get hashCode {
    return numeroAlbaran.hashCode ^
      fechaCreacion.hashCode ^
      codigoMovistar.hashCode ^
      nombreComercial.hashCode ^
      codigoCliente.hashCode ^
      nombreFiscal.hashCode;
  }
}
