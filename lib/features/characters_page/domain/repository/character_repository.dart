import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';

abstract class ICharacterRepository {
  // status is used to fetch heroes depending on their status
  Future<List<Character>> fetchCharacters([String? status]);
}
