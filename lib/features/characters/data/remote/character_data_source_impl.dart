import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../model/character_model.dart';
import 'character_data_source.dart';

@LazySingleton(as: CharacterDataSource)
class CharacterDataSourceImpl implements CharacterDataSource {
  const CharacterDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get('/en/characters');
      final data = response.data;
      final list = data is String ? jsonDecode(data) : data;
      return CharacterModel.fromJsonList(list as List<dynamic>?);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }
}