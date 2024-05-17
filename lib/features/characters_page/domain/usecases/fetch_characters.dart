import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/repository/character_repository.dart';

class FetchCharacters {
  FetchCharacters({
    required ICharacterRepository repository,
  }) : _repository = repository;

  final ICharacterRepository _repository;

//status is used to display heroes depending on their status
  Future<List<Character>> call([String? status]) async {
    final characters = await _repository.fetchCharacters(status);
    return characters;
  }
}
