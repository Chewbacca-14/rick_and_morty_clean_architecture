import 'package:rick_and_morty_clean_architecture/core/api/icharacter_api.dart';
import 'package:rick_and_morty_clean_architecture/constants/api_constants.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterApiImpl implements ICharacterApi {
  @override
  Future<List<Character>> fetchCharacters([String? status]) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/character'));
      List<Character> characters;
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (status != null) {
          characters = (jsonData['results'] as List)
              .map((characterJson) => Character.fromJson(characterJson))
              .where((character) => character.status == status)
              .toList();
        } else {
          characters = (jsonData['results'] as List)
              .map((characterJson) => Character.fromJson(characterJson))
              .toList();
        }

        return characters;
      } else {
        print('Failed to load data');
        return [];
      }
    } catch (e) {
      print('[Fetch Characters] $e');
      return [];
    }
  }
}
