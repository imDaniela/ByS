// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bys_app/pedidos/models/FacturaPendiente.dart';

class ClienteSaldoPendiente {
  List<FacturaPendiente> detalles;
  double deuda;
  ClienteSaldoPendiente({
    required this.detalles,
    required this.deuda,
  });

  ClienteSaldoPendiente copyWith({
    List<FacturaPendiente>? detalles,
    double? deuda,
  }) {
    return ClienteSaldoPendiente(
      detalles: detalles ?? this.detalles,
      deuda: deuda ?? this.deuda,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detalles': detalles.map((x) => x.toMap()).toList(),
      'deuda': deuda,
    };
  }

  factory ClienteSaldoPendiente.fromMap(Map<String, dynamic> map) {
    return ClienteSaldoPendiente(
      detalles: List<FacturaPendiente>.from(
        (map['detalles'] as List<dynamic>).map<FacturaPendiente>(
          (x) => FacturaPendiente.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deuda: double.tryParse(map['deuda'].toString()) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteSaldoPendiente.fromJson(String source) =>
      ClienteSaldoPendiente.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ClienteSaldoPendiente(detalles: $detalles, deuda: $deuda)';

  @override
  bool operator ==(covariant ClienteSaldoPendiente other) {
    if (identical(this, other)) return true;

    return listEquals(other.detalles, detalles) && other.deuda == deuda;
  }

  @override
  int get hashCode => detalles.hashCode ^ deuda.hashCode;
}
