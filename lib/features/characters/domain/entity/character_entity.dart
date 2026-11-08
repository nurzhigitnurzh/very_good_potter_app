import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  const CharacterEntity({
    required this.index,
    required this.fullName,
    required this.nickname,
    required this.house,
    required this.actor,
    required this.children,
    required this.image,
    required this.birthdate,
  });

  final int index;
  final String fullName;
  final String nickname;
  final String house;
  final String actor;
  final List<String> children;
  final String image;
  final String birthdate;

  @override
  List<Object?> get props => [
    index,
    fullName,
    nickname,
    house,
    actor,
    children,
    image,
    birthdate,
  ];
}