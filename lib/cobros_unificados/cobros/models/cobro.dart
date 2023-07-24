// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cobro {

  final String? canal;
  final int? year;
  final int? numeroFactura;
  final String? formaPago;
  final int? codigoCliente;
  final String? nombre;
  final String? nombreComercio;
  final double? importe;
  final String? fechaFactura;
  Cobro({
    this.canal,
    this.year,
    this.numeroFactura,
    this.formaPago,
    this.codigoCliente,
    this.nombre,
    this.nombreComercio,
    this.importe,
    this.fechaFactura,
  });

  Cobro copyWith({
    String? canal,
    int? year,
    int? numeroFactura,
    String? formaPago,
    int? codigoCliente,
    String? nombre,
    String? nombreComercio,
    double? importe,
    String? fechaFactura,
  }) {
    return Cobro(
      canal: canal ?? this.canal,
      year: year ?? this.year,
      numeroFactura: numeroFactura ?? this.numeroFactura,
      formaPago: formaPago ?? this.formaPago,
      codigoCliente: codigoCliente ?? this.codigoCliente,
      nombre: nombre ?? this.nombre,
      nombreComercio: nombreComercio ?? this.nombreComercio,
      importe: importe ?? this.importe,
      fechaFactura: fechaFactura ?? this.fechaFactura,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CAN': canal,
      'EJEFAC': year,
      'NUMFAC': numeroFactura,
      'FORPAG': formaPago,
      'CODCLI': codigoCliente,
      'nom': nombre,
      'cal2': nombreComercio,
      'importe': importe,
      'FECREM': fechaFactura,
    };
  }

  factory Cobro.fromMap(Map<String, dynamic> map) {
    return Cobro(
      canal: map['CAN'] != null ? map['CAN'] as String : null,
      year: map['EJEFAC'] != null ? map['EJEFAC'] as int : null,
      numeroFactura: map['NUMFAC'] != null ? map['NUMFAC'] as int : null,
      formaPago: map.containsKey('FORPAG') ? map['FORPAG'] != null ? map['FORPAG'] as String : null : null,
      codigoCliente: map['CODCLI'] != null ? map['CODCLI'] as int : null,
      nombre: map['nom'] != null ? map['nom'] as String : null,
      nombreComercio: map['cal2'] != null ? map['cal2'] as String : null,
      importe: map.containsKey('importe') ? (map['importe']?.toDouble())
        : map.containsKey('IMPCOB') ? (map['IMPCOB']?.toDouble()) : null ,
      fechaFactura: map.containsKey('FECREM') ? (map['FECREM'] != null ? map['FECREM'] as String : null)
        : map.containsKey('TS') ? (map['TS'] != null ? map['TS'] as String : null) : null
    );
  }

  String toJson() => json.encode(toMap());

  factory Cobro.fromJson(String source) => Cobro.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cobro(canal: $canal, year: $year, numeroFactura: $numeroFactura, formaPago: $formaPago, codigoCliente: $codigoCliente, nombre: $nombre, nombreComercio: $nombreComercio, importe: $importe, fechaFactura: $fechaFactura)';
  }

  @override
  bool operator ==(covariant Cobro other) {
    if (identical(this, other)) return true;
  
    return 
      other.canal == canal &&
      other.year == year &&
      other.numeroFactura == numeroFactura &&
      other.formaPago == formaPago &&
      other.codigoCliente == codigoCliente &&
      other.nombre == nombre &&
      other.nombreComercio == nombreComercio &&
      other.importe == importe &&
      other.fechaFactura == fechaFactura;
  }

  @override
  int get hashCode {
    return canal.hashCode ^
      year.hashCode ^
      numeroFactura.hashCode ^
      formaPago.hashCode ^
      codigoCliente.hashCode ^
      nombre.hashCode ^
      nombreComercio.hashCode ^
      importe.hashCode ^
      fechaFactura.hashCode;
  }
}
