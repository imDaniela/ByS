import 'dart:convert';

class Historial {
  int codcli;
  int codart;
  String desmod;
  int mes_1;
  int mes_2;
  int mes_3;
  int mes_4;
  int mes_5;
  int mes_6;
  int mes_7;
  int mes_8;
  int mes_9;
  int mes_10;
  int mes_11;
  int mes_12;
  Historial({
    required this.codcli,
    required this.codart,
    required this.desmod,
    required this.mes_1,
    required this.mes_2,
    required this.mes_3,
    required this.mes_4,
    required this.mes_5,
    required this.mes_6,
    required this.mes_7,
    required this.mes_8,
    required this.mes_9,
    required this.mes_10,
    required this.mes_11,
    required this.mes_12,
  });

  Historial copyWith({
    int? codcli,
    int? codart,
    String? desmod,
    int? mes_1,
    int? mes_2,
    int? mes_3,
    int? mes_4,
    int? mes_5,
    int? mes_6,
    int? mes_7,
    int? mes_8,
    int? mes_9,
    int? mes_10,
    int? mes_11,
    int? mes_12,
  }) {
    return Historial(
      codcli: codcli ?? this.codcli,
      codart: codart ?? this.codart,
      desmod: desmod ?? this.desmod,
      mes_1: mes_1 ?? this.mes_1,
      mes_2: mes_2 ?? this.mes_2,
      mes_3: mes_3 ?? this.mes_3,
      mes_4: mes_4 ?? this.mes_4,
      mes_5: mes_5 ?? this.mes_5,
      mes_6: mes_6 ?? this.mes_6,
      mes_7: mes_7 ?? this.mes_7,
      mes_8: mes_8 ?? this.mes_8,
      mes_9: mes_9 ?? this.mes_9,
      mes_10: mes_10 ?? this.mes_10,
      mes_11: mes_11 ?? this.mes_11,
      mes_12: mes_12 ?? this.mes_12,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'codcli': codcli});
    result.addAll({'codart': codart});
    result.addAll({'desmod': desmod});
    result.addAll({'mes_1': mes_1});
    result.addAll({'mes_2': mes_2});
    result.addAll({'mes_3': mes_3});
    result.addAll({'mes_4': mes_4});
    result.addAll({'mes_5': mes_5});
    result.addAll({'mes_6': mes_6});
    result.addAll({'mes_7': mes_7});
    result.addAll({'mes_8': mes_8});
    result.addAll({'mes_9': mes_9});
    result.addAll({'mes_10': mes_10});
    result.addAll({'mes_11': mes_11});
    result.addAll({'mes_12': mes_12});

    return result;
  }

  factory Historial.fromMap(Map<String, dynamic> map) {
    return Historial(
      codcli: int.tryParse(map['codcli'].toString() ?? '0') ?? 0,
      codart: int.tryParse(map['codart'].toString() ?? '0') ?? 0,
      desmod: map['desmod'] ?? '',
      mes_1: int.tryParse(map['mes_1'].toString() ?? '0') ?? 0,
      mes_2: int.tryParse(map['mes_2'].toString() ?? '0') ?? 0,
      mes_3: int.tryParse(map['mes_3'].toString() ?? '0') ?? 0,
      mes_4: int.tryParse(map['mes_4'].toString() ?? '0') ?? 0,
      mes_5: int.tryParse(map['mes_5'].toString() ?? '0') ?? 0,
      mes_6: int.tryParse(map['mes_6'].toString() ?? '0') ?? 0,
      mes_7: int.tryParse(map['mes_7'].toString() ?? '0') ?? 0,
      mes_8: int.tryParse(map['mes_8'].toString() ?? '0') ?? 0,
      mes_9: int.tryParse(map['mes_9'].toString() ?? '0') ?? 0,
      mes_10: int.tryParse(map['mes_10'].toString() ?? '0') ?? 0,
      mes_11: int.tryParse(map['mes_11'].toString() ?? '0') ?? 0,
      mes_12: int.tryParse(map['mes_12'].toString() ?? '0') ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Historial.fromJson(String source) =>
      Historial.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Historial(codcli: $codcli, codart: $codart, desmod: $desmod, mes_1: $mes_1, mes_2: $mes_2, mes_3: $mes_3, mes_4: $mes_4, mes_5: $mes_5, mes_6: $mes_6, mes_7: $mes_7, mes_8: $mes_8, mes_9: $mes_9, mes_10: $mes_10, mes_11: $mes_11, mes_12: $mes_12)';
  }

  static List<Historial>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<Historial>.from(elementos.map((e) {
      return Historial.fromMap(e);
    }));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Historial &&
        other.codcli == codcli &&
        other.codart == codart &&
        other.desmod == desmod &&
        other.mes_1 == mes_1 &&
        other.mes_2 == mes_2 &&
        other.mes_3 == mes_3 &&
        other.mes_4 == mes_4 &&
        other.mes_5 == mes_5 &&
        other.mes_6 == mes_6 &&
        other.mes_7 == mes_7 &&
        other.mes_8 == mes_8 &&
        other.mes_9 == mes_9 &&
        other.mes_10 == mes_10 &&
        other.mes_11 == mes_11 &&
        other.mes_12 == mes_12;
  }

  @override
  int get hashCode {
    return codcli.hashCode ^
        codart.hashCode ^
        desmod.hashCode ^
        mes_1.hashCode ^
        mes_2.hashCode ^
        mes_3.hashCode ^
        mes_4.hashCode ^
        mes_5.hashCode ^
        mes_6.hashCode ^
        mes_7.hashCode ^
        mes_8.hashCode ^
        mes_9.hashCode ^
        mes_10.hashCode ^
        mes_11.hashCode ^
        mes_12.hashCode;
  }
}
