
import '../model/character_model.dart';

abstract interface class CharacterDataSource {
  Future<List<CharacterModel>> getCharacters();
}