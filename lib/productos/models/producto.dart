// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Producto {
  String codart;
  String des;
  double desc;
  int sto;
  double prevena;
  String? rel;
  bool envase;
  Producto(
      {required this.codart,
      required this.des,
      required this.sto,
      required this.prevena,
      required this.desc,
      this.rel,
      this.envase = false});

  Producto copyWith({
    String? codart,
    String? des,
    int? sto,
    double? desc,
    double? prevena,
    String? rel,
    bool? envase,
  }) {
    return Producto(
      codart: codart ?? this.codart,
      des: des ?? this.des,
      sto: sto ?? this.sto,
      prevena: prevena ?? this.prevena,
      desc: desc ?? this.desc,
      rel: rel ?? this.rel,
      envase: envase ?? this.envase,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codart': codart,
      'des': des,
      'sto': sto,
      'prevena': prevena,
      'desc': des,
      'rel': rel,
      'envase': envase
    };
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
        codart: map['codart'] as String,
        des: map['des'] as String,
        sto: map['sto'] == null ? 0 : map['sto'] as int,
        prevena: double.parse(map['prevena'].toString()),
        desc: double.tryParse(map['desc'].toString()) ?? 0,
        rel: map['rel'],
        envase: map['envase']);
  }

  String toJson() => json.encode(toMap());

  factory Producto.fromJson(String source) =>
      Producto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Producto(codart: $codart, des: $des, sto: $sto, prevena: $prevena, desc:$desc,rel: $rel)';
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
