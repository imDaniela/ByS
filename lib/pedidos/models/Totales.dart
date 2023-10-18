// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Totales {
  int? numped;
  double subtotal;
  double iva;
  double totped;
  String? observa; //notas
  String? obsint; //notas internas
  Totales(
      {required this.subtotal,
      required this.iva,
      required this.totped,
      this.observa,
      this.obsint,
      this.numped});

  Totales copyWith({
    double? subtotal,
    double? iva,
    double? totped,
    String? observa,
    String? obsint,
    int? numped,
  }) {
    return Totales(
        subtotal: subtotal ?? this.subtotal,
        iva: iva ?? this.iva,
        totped: totped ?? this.totped,
        observa: observa ?? this.observa,
        obsint: obsint ?? this.obsint,
        numped: numped ?? this.numped);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subtotal': subtotal,
      'iva': iva,
      'totped': totped,
      'observa': observa,
      'obsint': obsint,
      'numped': numped
    };
  }

  factory Totales.fromMap(Map<String, dynamic> map) {
    return Totales(
        subtotal: double.parse(map['subtotal'].toString()),
        iva: double.parse(map['iva'].toString()),
        totped: double.parse(map['totped'].toString()),
        observa: map['observa'] ?? '',
        obsint: map['obsint'] ?? '',
        numped: map['numped']);
  }

  String toJson() => json.encode(toMap());

  factory Totales.fromJson(String source) =>
      Totales.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Totales(subtotal: $subtotal, iva: $iva, totped: $totped,observa:${observa}, obsint: ${obsint}, numped: ${numped})';

  @override
  bool operator ==(covariant Totales other) {
    if (identical(this, other)) return true;

    return other.subtotal == subtotal &&
        other.iva == iva &&
        other.totped == totped;
  }

  @override
  int get hashCode => subtotal.hashCode ^ iva.hashCode ^ totped.hashCode;
}
