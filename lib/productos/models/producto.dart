// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Producto {
  int codart;
  String des;
  int sto;
  double prevena;
  Producto({
    required this.codart,
    required this.des,
    required this.sto,
    required this.prevena,
  });

  Producto copyWith({
    int? codart,
    String? des,
    int? sto,
    double? prevena,
  }) {
    return Producto(
      codart: codart ?? this.codart,
      des: des ?? this.des,
      sto: sto ?? this.sto,
      prevena: prevena ?? this.prevena,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codart': codart,
      'des': des,
      'sto': sto,
      'prevena': prevena,
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      codart: int.parse(map['codart']),
      des: map['des'] as String,
      sto: map['sto'] == null ? 0 : map['sto'] as int,
      prevena: double.parse(map['prevena'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Producto.fromJson(String source) =>
      Producto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Producto(codart: $codart, des: $des, sto: $sto, prevena: $prevena)';
  }

  @override
  bool operator ==(covariant Producto other) {
    if (identical(this, other)) return true;

    return other.codart == codart &&
        other.des == des &&
        other.sto == sto &&
        other.prevena == prevena;
  }

  @override
  int get hashCode {
    return codart.hashCode ^ des.hashCode ^ sto.hashCode ^ prevena.hashCode;
  }
}
