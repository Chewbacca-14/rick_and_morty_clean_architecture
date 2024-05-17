import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';

abstract class ICharacterApi {
  Future<List<Character>> fetchCharacters([String? status]);
}
