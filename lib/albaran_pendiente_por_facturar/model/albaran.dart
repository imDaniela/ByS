import 'dart:convert';

class Albaran {
  int numalb;
  int codart;
  String desmod;
  int canser;
  int preven;
  int tandto;
  int subtot;
  Albaran({
    required this.numalb,
    required this.codart,
    required this.desmod,
    required this.canser,
    required this.preven,
    required this.tandto,
    required this.subtot,
  });

  Albaran copyWith({
    int? numalb,
    int? codart,
    String? desmod,
    int? canser,
    int? preven,
    int? tandto,
    int? subtot,
  }) {
    return Albaran(
      numalb: numalb ?? this.numalb,
      codart: codart ?? this.codart,
      desmod: desmod ?? this.desmod,
      canser: canser ?? this.canser,
      preven: preven ?? this.preven,
      tandto: tandto ?? this.tandto,
      subtot: subtot ?? this.subtot,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'numalb': numalb});
    result.addAll({'codart': codart});
    result.addAll({'desmod': desmod});
    result.addAll({'canser': canser});
    result.addAll({'preven': preven});
    result.addAll({'tandto': tandto});
    result.addAll({'subtot': subtot});

    return result;
  }

  factory Albaran.fromMap(Map<String, dynamic> map) {
    return Albaran(
      numalb: int.tryParse(map['numalb'].toString() ?? '0') ?? 0,
      codart: int.tryParse(map['codart'].toString() ?? '0') ?? 0,
      desmod: map['desmod'] ?? '',
      canser: int.tryParse(map['canser'].toString() ?? '0') ?? 0,
      preven: int.tryParse(map['preven'].toString() ?? '0') ?? 0,
      tandto: int.tryParse(map['tandto'].toString() ?? '0') ?? 0,
      subtot: int.tryParse(map['subtot'].toString() ?? '0') ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Albaran.fromJson(String source) =>
      Albaran.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Albaran(numalb: $numalb, codart: $codart, desmod: $desmod, canser: $canser, preven: $preven, tandto: $tandto, subtot: $subtot)';
  }

  static List<Albaran>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<Albaran>.from(elementos.map((e) {
      return Albaran.fromMap(e);
    }));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Albaran &&
        other.numalb == numalb &&
        other.codart == codart &&
        other.desmod == desmod &&
        other.canser == canser &&
        other.preven == preven &&
        other.tandto == tandto &&
        other.subtot == subtot;
  }

  @override
  int get hashCode {
    return numalb.hashCode ^
        codart.hashCode ^
        desmod.hashCode ^
        canser.hashCode ^
        preven.hashCode ^
        tandto.hashCode ^
        subtot.hashCode;
  }
}
