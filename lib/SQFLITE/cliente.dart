// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  final int id;
  final String clienteNome;
  final int clienteFone;
  final String clienteCreatedAt;
  final String? clienteUpdatedAt;
  Cliente({
    required this.id,
    required this.clienteNome,
    required this.clienteFone,
    required this.clienteCreatedAt,
    this.clienteUpdatedAt,
  });

  Cliente copyWith({
    int? id,
    String? clienteNome,
    int? clienteFone,
    String? clienteCreatedAt,
    String? clienteCpdatedAt,
  }) {
    return Cliente(
      id: id ?? this.id,
      clienteNome: clienteNome ?? this.clienteNome,
      clienteFone: clienteFone ?? this.clienteFone,
      clienteCreatedAt: clienteCreatedAt ?? this.clienteCreatedAt,
      clienteUpdatedAt: clienteCpdatedAt ?? this.clienteUpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clienteNome': clienteNome,
      'clienteFone': clienteFone,
      'clienteCreatedAt': clienteCreatedAt,
      'clienteCpdatedAt': clienteUpdatedAt,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as int,
      clienteNome: map['clienteNome'] as String,
      clienteFone: map['clienteFone'] as int,
      clienteCreatedAt: map['clienteCreatedAt'] as String,
      clienteUpdatedAt: map['clienteCpdatedAt'] != null
          ? map['clienteCpdatedAt'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cliente(id: $id, clienteNome: $clienteNome, clienteFone: $clienteFone, clienteCreatedAt: $clienteCreatedAt, clienteCpdatedAt: $clienteUpdatedAt)';
  }

  @override
  bool operator ==(covariant Cliente other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.clienteNome == clienteNome &&
        other.clienteFone == clienteFone &&
        other.clienteCreatedAt == clienteCreatedAt &&
        other.clienteUpdatedAt == clienteUpdatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clienteNome.hashCode ^
        clienteFone.hashCode ^
        clienteCreatedAt.hashCode ^
        clienteUpdatedAt.hashCode;
  }
}
