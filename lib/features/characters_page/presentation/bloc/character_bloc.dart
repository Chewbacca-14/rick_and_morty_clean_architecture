import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/usecases/fetch_characters.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_events.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_states.dart';

class CharacterBloc extends Bloc<CharacterEvents, CharacterStates> {
  final FetchCharacters _fetchCharacters;

  CharacterBloc({
    required FetchCharacters fetchCharacters,
  })  : _fetchCharacters = fetchCharacters,
        super(CharacterLoadingState()) {
    on<FetchCharacterData>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        List<Character> characters = await _fetchCharacters.call(event.status);
        if (characters.isEmpty) {
          emit(CharacterEmptyState());
        } else {
          emit(
            CharacterSuccessState(
              characters: characters,
            ),
          );
        }
      } catch (e) {
        emit(
          CharacterErrorState(
            'Error: $e',
          ),
        );
      }
    });
  }
}
