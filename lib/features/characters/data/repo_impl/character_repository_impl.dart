import 'package:injectable/injectable.dart';
import '../../domain/entity/character_entity.dart';
import '../../domain/repo/character_repository.dart';
import '../remote/character_data_source.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  const CharacterRepositoryImpl({required this.dataSource});

  final CharacterDataSource dataSource;

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    final models = await dataSource.getCharacters();
    return models.map((e) => e.toEntity()).toList();
  }
}