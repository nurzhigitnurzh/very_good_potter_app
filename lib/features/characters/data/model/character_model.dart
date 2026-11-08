
import '../../domain/entity/character_entity.dart';

class CharacterModel {
  const CharacterModel({
    this.index,
    this.fullName,
    this.nickname,
    this.hogwartsHouse,
    this.interpretedBy,
    this.children,
    this.image,
    this.birthdate,
  });

  final int? index;
  final String? fullName;
  final String? nickname;
  final String? hogwartsHouse;
  final String? interpretedBy;
  final List<String>? children;
  final String? image;
  final String? birthdate;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      index: json['index'] as int?,
      fullName: json['fullName'] as String?,
      nickname: json['nickname'] as String?,
      hogwartsHouse: json['hogwartsHouse'] as String?,
      interpretedBy: json['interpretedBy'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      image: json['image'] as String?,
      birthdate: json['birthdate'] as String?,
    );
  }

  static List<CharacterModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];
    return list
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      index: index ?? -1,
      fullName: fullName ?? '',
      nickname: nickname ?? '',
      house: hogwartsHouse ?? 'Unknown',
      actor: (interpretedBy ?? '').isEmpty ? '—' : interpretedBy!,
      children: children ?? const [],
      image: image ?? '',
      birthdate: birthdate ?? '—',
    );
  }
}