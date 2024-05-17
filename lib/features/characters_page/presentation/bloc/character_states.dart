import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';

sealed class CharacterStates {}

class CharacterErrorState extends CharacterStates {
  final String? errorMessage;
  CharacterErrorState(this.errorMessage);
}

class CharacterEmptyState extends CharacterStates {}

class CharacterLoadingState extends CharacterStates {}

class CharacterSuccessState extends CharacterStates {
  List<Character> characters;
  CharacterSuccessState({required this.characters});
}
