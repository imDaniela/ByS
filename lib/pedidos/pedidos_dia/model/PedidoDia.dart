// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PedidoDia {
  int numped;
  int codcli;
  DateTime fecped;
  double totped;
  String cliente;
  PedidoDia({
    required this.numped,
    required this.codcli,
    required this.fecped,
    required this.totped,
    required this.cliente,
  });

  PedidoDia copyWith({
    int? numped,
    int? codcli,
    DateTime? fecped,
    double? totped,
    String? cliente,
  }) {
    return PedidoDia(
      numped: numped ?? this.numped,
      codcli: codcli ?? this.codcli,
      fecped: fecped ?? this.fecped,
      totped: totped ?? this.totped,
      cliente: cliente ?? this.cliente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numped': numped,
      'codcli': codcli,
      'fecped': fecped.millisecondsSinceEpoch,
      'totped': totped,
      'cliente': cliente,
    };
  }

  factory PedidoDia.fromMap(Map<String, dynamic> map) {
    return PedidoDia(
      numped: map['numped'] as int,
      codcli: map['codcli'] as int,
      fecped: DateTime.parse(map['fecped'].toString()),
      totped: double.parse(map['totped'].toString()),
      cliente: map['cliente'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PedidoDia.fromJson(String source) =>
      PedidoDia.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PedidoDia(numped: $numped, codcli: $codcli, fecped: $fecped, totped: $totped, cliente: $cliente)';
  }

  static List<PedidoDia>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<PedidoDia>.from(elementos.map((e) {
      return PedidoDia.fromMap(e);
    }));
  }

  @override
  bool operator ==(covariant PedidoDia other) {
    if (identical(this, other)) return true;

    return other.numped == numped &&
        other.codcli == codcli &&
        other.fecped == fecped &&
        other.totped == totped &&
        other.cliente == cliente;
  }

  @override
  int get hashCode {
    return numped.hashCode ^
        codcli.hashCode ^
        fecped.hashCode ^
        totped.hashCode ^
        cliente.hashCode;
  }
}
