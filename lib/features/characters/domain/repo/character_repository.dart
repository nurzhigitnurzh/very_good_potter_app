
import '../entity/character_entity.dart';

abstract interface class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters();
}