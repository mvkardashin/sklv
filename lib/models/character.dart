import 'dart:convert';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String imageUrl;
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.imageUrl,
  });

  Character copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? imageUrl,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'imageUrl': imageUrl,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      imageUrl: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Character(id: $id, name: $name, status: $status, species: $species, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Character &&
        other.id == id &&
        other.name == name &&
        other.status == status &&
        other.species == species &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        species.hashCode ^
        imageUrl.hashCode;
  }
}
