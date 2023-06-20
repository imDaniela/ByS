// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FacturaAlbaran {
  int numalb;
  int codart;
  String desmod;
  int canser;
  double preven;
  double subtot;
  DateTime fecgar;
  int numfac;
  FacturaAlbaran({
    required this.numalb,
    required this.codart,
    required this.desmod,
    required this.canser,
    required this.preven,
    required this.subtot,
    required this.fecgar,
    required this.numfac,
  });

  FacturaAlbaran copyWith({
    int? numalb,
    int? codart,
    String? desmod,
    int? canser,
    double? preven,
    double? subtot,
    DateTime? fecgar,
    int? numfac,
  }) {
    return FacturaAlbaran(
      numalb: numalb ?? this.numalb,
      codart: codart ?? this.codart,
      desmod: desmod ?? this.desmod,
      canser: canser ?? this.canser,
      preven: preven ?? this.preven,
      subtot: subtot ?? this.subtot,
      fecgar: fecgar ?? this.fecgar,
      numfac: numfac ?? this.numfac,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numalb': numalb,
      'codart': codart,
      'desmod': desmod,
      'canser': canser,
      'preven': preven,
      'subtot': subtot,
      'fecgar': fecgar.millisecondsSinceEpoch,
      'numfac': numfac,
    };
  }

  factory FacturaAlbaran.fromMap(Map<String, dynamic> map) {
    return FacturaAlbaran(
      numalb: map['numalb'] as int,
      codart: int.tryParse(map['codart'].toString()) ?? 0,
      desmod: map['desmod'] as String,
      canser: map['canser'] as int,
      preven: double.parse(map['preven'].toString()),
      subtot: double.parse(map['subtot'].toString()),
      fecgar: DateTime.parse(map['fecgar'] as String),
      numfac: map['numfac'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacturaAlbaran.fromJson(String source) =>
      FacturaAlbaran.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FacturaAlbaran(numalb: $numalb, codart: $codart, desmod: $desmod, canser: $canser, preven: $preven, subtot: $subtot, fecgar: $fecgar, numfac: $numfac)';
  }

  @override
  bool operator ==(covariant FacturaAlbaran other) {
    if (identical(this, other)) return true;

    return other.numalb == numalb &&
        other.codart == codart &&
        other.desmod == desmod &&
        other.canser == canser &&
        other.preven == preven &&
        other.subtot == subtot &&
        other.fecgar == fecgar &&
        other.numfac == numfac;
  }

  @override
  int get hashCode {
    return numalb.hashCode ^
        codart.hashCode ^
        desmod.hashCode ^
        canser.hashCode ^
        preven.hashCode ^
        subtot.hashCode ^
        fecgar.hashCode ^
        numfac.hashCode;
  }
}
