import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/character_repository.dart';
import 'characters_event.dart';
import 'characters_state.dart';

@injectable
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required this.repository})
      : super(const CharactersInitial()) {
    on<GetCharactersEvent>(_onGetCharacters);
  }

  final CharacterRepository repository;

  Future<void> _onGetCharacters(
      GetCharactersEvent event,
      Emitter<CharactersState> emit,
      ) async {
    if (!event.silent) emit(const CharactersLoading());

    try {
      final characters = await repository.getCharacters();
      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(CharactersError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}