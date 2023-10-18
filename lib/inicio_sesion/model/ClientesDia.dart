import 'dart:convert';

class ClientesDia {
  int codcli;
  String ordenvisit;
  String ampm;
  int Ordgeo2;
  int Ordgeo1;
  String cal2;
  String nom;
  ClientesDia({
    required this.codcli,
    required this.ordenvisit,
    required this.ampm,
    required this.Ordgeo2,
    required this.Ordgeo1,
    required this.cal2,
    required this.nom,
  });

  ClientesDia copyWith({
    int? codcli,
    String? ordenvisit,
    String? ampm,
    int? Ordgeo2,
    int? Ordgeo1,
    String? cal2,
    String? nom,
  }) {
    return ClientesDia(
      codcli: codcli ?? this.codcli,
      ordenvisit: ordenvisit ?? this.ordenvisit,
      ampm: ampm ?? this.ampm,
      Ordgeo2: Ordgeo2 ?? this.Ordgeo2,
      Ordgeo1: Ordgeo1 ?? this.Ordgeo1,
      cal2: cal2 ?? this.cal2,
      nom: nom ?? this.nom,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'codcli': codcli});
    result.addAll({'ordenvisit': ordenvisit});
    result.addAll({'ampm': ampm});
    result.addAll({'Ordgeo2': Ordgeo2});
    result.addAll({'Ordgeo1': Ordgeo1});
    result.addAll({'cal2': cal2});
    result.addAll({'nom': nom});

    return result;
  }

  factory ClientesDia.fromMap(Map<String, dynamic> map) {
    return ClientesDia(
      codcli: map['codcli']?.toInt() ?? 0,
      ordenvisit: map['ordenvisit'].toString() ?? '',
      ampm: map['ampm'] ?? '',
      Ordgeo2: map['Ordgeo2']?.toInt() ?? 0,
      Ordgeo1: map['Ordgeo1']?.toInt() ?? 0,
      cal2: map['cal2'] ?? '',
      nom: map['nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientesDia.fromJson(String source) =>
      ClientesDia.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientesDia(codcli: $codcli, ordenvisit: $ordenvisit, ampm: $ampm, Ordgeo2: $Ordgeo2, Ordgeo1: $Ordgeo1, cal2: $cal2, nom: $nom)';
  }

  String toStringSearch() {
    return '$codcli $ordenvisit $ampm $Ordgeo2 $Ordgeo1 $cal2 $nom';
  }

  static List<ClientesDia>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<ClientesDia>.from(elementos.map((e) {
      print(e);
      return ClientesDia.fromMap(e);
    }));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClientesDia &&
        other.codcli == codcli &&
        other.ordenvisit == ordenvisit &&
        other.ampm == ampm &&
        other.Ordgeo2 == Ordgeo2 &&
        other.Ordgeo1 == Ordgeo1 &&
        other.cal2 == cal2 &&
        other.nom == nom;
  }

  @override
  int get hashCode {
    return codcli.hashCode ^
        ordenvisit.hashCode ^
        ampm.hashCode ^
        Ordgeo2.hashCode ^
        Ordgeo1.hashCode ^
        cal2.hashCode ^
        nom.hashCode;
  }
}
