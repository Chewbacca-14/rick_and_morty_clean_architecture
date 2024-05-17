import 'package:rick_and_morty_clean_architecture/core/api/icharacter_api.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements ICharacterRepository {
  final ICharacterApi _api;
  CharacterRepositoryImpl({
    required ICharacterApi api,
  }) : _api = api;

  @override
  //status is used to display heroes depending on their status
  Future<List<Character>> fetchCharacters([String? status]) async {
    final charactersList = await _api.fetchCharacters(status);
    return charactersList;
  }
}
