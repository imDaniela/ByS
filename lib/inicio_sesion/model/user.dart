import 'dart:convert';

class User {
  int CODREP;
  String NOM;
  User({
    required this.CODREP,
    required this.NOM,
  });

  User copyWith({
    int? CODREP,
    String? NOM,
  }) {
    return User(
      CODREP: CODREP ?? this.CODREP,
      NOM: NOM ?? this.NOM,
    );
  }

  static List<User>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<User>.from(elementos.map((e) {
      return User.fromMap(e);
    }));
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'CODREP': CODREP});
    result.addAll({'NOM': NOM});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      CODREP: map['CODREP']?.toInt() ?? 0,
      NOM: map['NOM'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(CODREP: $CODREP, NOM: $NOM)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.CODREP == CODREP && other.NOM == NOM;
  }

  @override
  int get hashCode => CODREP.hashCode ^ NOM.hashCode;
}
