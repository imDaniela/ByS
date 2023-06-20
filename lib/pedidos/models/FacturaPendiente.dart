// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bys_app/pedidos/models/FacturaAlbaran.dart';

class FacturaPendiente {
  String? Can;
  int? numfac;
  int? ejefac;
  DateTime? fecfac;
  DateTime? fecven;
  double? imprec;
  double? impcob;
  double? restofactura;
  List<FacturaAlbaran>? albfaclis;
  double? cobrohoy;
  FacturaPendiente({
    this.Can,
    this.numfac,
    this.ejefac,
    this.fecfac,
    this.fecven,
    this.imprec,
    this.impcob,
    this.restofactura,
    this.albfaclis,
    this.cobrohoy,
  });

  FacturaPendiente copyWith({
    String? Can,
    int? numfac,
    int? ejefac,
    DateTime? fecfac,
    DateTime? fecven,
    double? imprec,
    double? impcob,
    double? restofactura,
    List<FacturaAlbaran>? albfaclis,
    double? cobrohoy,
  }) {
    return FacturaPendiente(
      Can: Can ?? this.Can,
      numfac: numfac ?? this.numfac,
      ejefac: ejefac ?? this.ejefac,
      fecfac: fecfac ?? this.fecfac,
      fecven: fecven ?? this.fecven,
      imprec: imprec ?? this.imprec,
      impcob: impcob ?? this.impcob,
      restofactura: restofactura ?? this.restofactura,
      albfaclis: albfaclis ?? this.albfaclis,
      cobrohoy: cobrohoy ?? this.cobrohoy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Can': Can,
      'numfac': numfac,
      'ejefac': ejefac,
      'fecfac': fecfac?.millisecondsSinceEpoch,
      'fecven': fecven?.millisecondsSinceEpoch,
      'imprec': imprec,
      'impcob': impcob,
      'restofactura': restofactura,
      'albfaclis':
          albfaclis == null ? [] : albfaclis!.map((x) => x?.toMap()).toList(),
      'cobrohoy': cobrohoy,
    };
  }

  factory FacturaPendiente.fromMap(Map<String, dynamic> map) {
    return FacturaPendiente(
      Can: map['Can'] != null ? map['Can'] as String : null,
      numfac: map['numfac'] != null ? map['numfac'] as int : null,
      ejefac: map['ejefac'] != null ? map['ejefac'] as int : null,
      fecfac: map['fecfac'] != null
          ? DateTime.parse(map['fecfac'] as String)
          : null,
      fecven: map['fecven'] != null
          ? DateTime.parse(map['fecven'] as String)
          : null,
      imprec:
          map['imprec'] != null ? double.parse(map['imprec'].toString()) : null,
      impcob:
          map['impcob'] != null ? double.parse(map['impcob'].toString()) : null,
      restofactura: map['restofactura'] != null
          ? double.parse(map['restofactura'].toString())
          : null,
      albfaclis: map['albfaclis'] != null
          ? List<FacturaAlbaran>.from(
              (map['albfaclis'] as List<dynamic>).map<FacturaAlbaran?>(
                (x) => FacturaAlbaran.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      cobrohoy: map['cobrohoy'] != null
          ? double.parse(map['cobrohoy'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacturaPendiente.fromJson(String source) =>
      FacturaPendiente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FacturaPendiente(Can: $Can, numfac: $numfac, ejefac: $ejefac, fecfac: $fecfac, fecven: $fecven, imprec: $imprec, impcob: $impcob, restofactura: $restofactura, albfaclis: $albfaclis, cobrohoy: $cobrohoy)';
  }

  @override
  bool operator ==(covariant FacturaPendiente other) {
    if (identical(this, other)) return true;

    return other.Can == Can &&
        other.numfac == numfac &&
        other.ejefac == ejefac &&
        other.fecfac == fecfac &&
        other.fecven == fecven &&
        other.imprec == imprec &&
        other.impcob == impcob &&
        other.restofactura == restofactura &&
        listEquals(other.albfaclis, albfaclis) &&
        other.cobrohoy == cobrohoy;
  }

  @override
  int get hashCode {
    return Can.hashCode ^
        numfac.hashCode ^
        ejefac.hashCode ^
        fecfac.hashCode ^
        fecven.hashCode ^
        imprec.hashCode ^
        impcob.hashCode ^
        restofactura.hashCode ^
        albfaclis.hashCode ^
        cobrohoy.hashCode;
  }
}
