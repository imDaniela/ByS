// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CobroPendienteDetalles {

  final int? anoFactura;
  final int? numeroFactura;
  final String? fechaFactura;
  final String? fechaVencimiento;
  final double? importe;
  final double? importeFacturado;
  final double? importePendiente;
  CobroPendienteDetalles({
    this.anoFactura,
    this.numeroFactura,
    this.fechaFactura,
    this.fechaVencimiento,
    this.importe,
    this.importeFacturado,
    this.importePendiente,
  });


  CobroPendienteDetalles copyWith({
    int? anoFactura,
    int? numeroFactura,
    String? fechaFactura,
    String? fechaVencimiento,
    double? importe,
    double? importeFacturado,
    double? importePendiente,
  }) {
    return CobroPendienteDetalles(
      anoFactura: anoFactura ?? this.anoFactura,
      numeroFactura: numeroFactura ?? this.numeroFactura,
      fechaFactura: fechaFactura ?? this.fechaFactura,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      importe: importe ?? this.importe,
      importeFacturado: importeFacturado ?? this.importeFacturado,
      importePendiente: importePendiente ?? this.importePendiente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ejefac': anoFactura,
      'numfac': numeroFactura,
      'fecfac': fechaFactura,
      'fecven': fechaVencimiento,
      'imprec': importe,
      'impcob': importeFacturado,
      'restofactura': importePendiente,
    };
  }

  factory CobroPendienteDetalles.fromMap(Map<String, dynamic> map) {
    return CobroPendienteDetalles(
      anoFactura: map['ejefac'] != null ? map['ejefac'] as int : null,
      numeroFactura: map['numfac'] != null ? map['numfac'] as int : null,
      fechaFactura: map['fecfac'] != null ? map['fecfac'] as String : null,
      fechaVencimiento: map['fecven'] != null ? map['fecven'] as String : null,
      importe: map['imprec']?.toDouble(),
      importeFacturado: map['impcob']?.toDouble(),
      importePendiente: map['restofactura']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CobroPendienteDetalles.fromJson(String source) => CobroPendienteDetalles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CobroPendienteDetalles(anoFactura: $anoFactura, numeroFactura: $numeroFactura, fechaFactura: $fechaFactura, fechaVencimiento: $fechaVencimiento, importe: $importe, importeFacturado: $importeFacturado, importePendiente: $importePendiente)';
  }

  @override
  bool operator ==(covariant CobroPendienteDetalles other) {
    if (identical(this, other)) return true;
  
    return 
      other.anoFactura == anoFactura &&
      other.numeroFactura == numeroFactura &&
      other.fechaFactura == fechaFactura &&
      other.fechaVencimiento == fechaVencimiento &&
      other.importe == importe &&
      other.importeFacturado == importeFacturado &&
      other.importePendiente == importePendiente;
  }

  @override
  int get hashCode {
    return anoFactura.hashCode ^
      numeroFactura.hashCode ^
      fechaFactura.hashCode ^
      fechaVencimiento.hashCode ^
      importe.hashCode ^
      importeFacturado.hashCode ^
      importePendiente.hashCode;
  }
}
