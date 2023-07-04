// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Alerta {
  int id;
  int id_cliente;
  DateTime fecha;
  String comentario;
  int codrep;
  String? Cliente;

  Alerta({
    required this.id,
    required this.id_cliente,
    required this.fecha,
    required this.comentario,
    required this.codrep,
    this.Cliente,
  });
  static List<Alerta>? fromJsonList(String source) {
    List<dynamic> elementos = jsonDecode(source);
    return List<Alerta>.from(elementos.map((e) {
      return Alerta.fromMap(e);
    }));
  }

  Alerta copyWith({
    int? id,
    int? id_cliente,
    DateTime? fecha,
    String? comentario,
    int? codrep,
    String? Cliente,
  }) {
    return Alerta(
      id: id ?? this.id,
      id_cliente: id_cliente ?? this.id_cliente,
      fecha: fecha ?? this.fecha,
      comentario: comentario ?? this.comentario,
      codrep: codrep ?? this.codrep,
      Cliente: Cliente ?? this.Cliente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_cliente': id_cliente,
      'fecha': fecha.millisecondsSinceEpoch,
      'comentario': comentario,
      'codrep': codrep,
      'Cliente': Cliente,
    };
  }

  factory Alerta.fromMap(Map<String, dynamic> map) {
    return Alerta(
      id: int.parse(map['id'].toString()),
      id_cliente: int.parse(map['id_cliente'].toString()),
      fecha: DateTime.parse(map['fecha'].toString()),
      comentario: map['comentario'] as String,
      codrep: int.parse(map['codrep'].toString()),
      Cliente: map['cliente'] != null ? map['cliente'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Alerta.fromJson(String source) =>
      Alerta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Alerta(id: $id, id_cliente: $id_cliente, fecha: $fecha, comentario: $comentario, codrep: $codrep, Cliente: $Cliente)';
  }

  @override
  bool operator ==(covariant Alerta other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.id_cliente == id_cliente &&
        other.fecha == fecha &&
        other.comentario == comentario &&
        other.codrep == codrep &&
        other.Cliente == Cliente;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        id_cliente.hashCode ^
        fecha.hashCode ^
        comentario.hashCode ^
        codrep.hashCode ^
        Cliente.hashCode;
  }
}
