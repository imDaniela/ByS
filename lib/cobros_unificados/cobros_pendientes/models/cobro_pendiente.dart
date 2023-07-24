// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CobroPendiente {

  final int? codigoCliente;
  final double? importe;
  final String? nombreFiscal;
  final String? nombreComercial;
  CobroPendiente({
    this.codigoCliente,
    this.importe,
    this.nombreFiscal,
    this.nombreComercial,
  });


  CobroPendiente copyWith({
    int? codigoCliente,
    double? importe,
    String? nombreFiscal,
    String? nombreComercial,
  }) {
    return CobroPendiente(
      codigoCliente: codigoCliente ?? this.codigoCliente,
      importe: importe ?? this.importe,
      nombreFiscal: nombreFiscal ?? this.nombreFiscal,
      nombreComercial: nombreComercial ?? this.nombreComercial,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CODCLI': codigoCliente,
      'tfactura': importe,
      'cliente': {
        'CODCLI': codigoCliente,
        'nom': nombreFiscal,
        'cal2': nombreComercial
      }
    };
  }

  factory CobroPendiente.fromMap(Map<String, dynamic> map) {
    return CobroPendiente(
      codigoCliente: map['CODCLI'] != null ? map['CODCLI'] as int : null,
      importe: map['tfactura']?.toDouble(),
      nombreFiscal: map['cliente']['nom'] != null ? map['cliente']['nom'] as String : null,
      nombreComercial: map['cliente']['cal2'] != null ? map['cliente']['cal2'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CobroPendiente.fromJson(String source) => CobroPendiente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CobroPendiente(codigoCliente: $codigoCliente, importe: $importe, nombreFiscal: $nombreFiscal, nombreComercial: $nombreComercial)';
  }

  @override
  bool operator ==(covariant CobroPendiente other) {
    if (identical(this, other)) return true;
  
    return 
      other.codigoCliente == codigoCliente &&
      other.importe == importe &&
      other.nombreFiscal == nombreFiscal &&
      other.nombreComercial == nombreComercial;
  }

  @override
  int get hashCode {
    return codigoCliente.hashCode ^
      importe.hashCode ^
      nombreFiscal.hashCode ^
      nombreComercial.hashCode;
  }
}
