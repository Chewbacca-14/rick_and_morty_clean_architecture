import 'package:equatable/equatable.dart';

abstract class CharacterEvents extends Equatable {}

class FetchCharacterData extends CharacterEvents {
  //used to fetch heroes depending on their status
  final String? status;
  FetchCharacterData([this.status]);

  @override
  List<Object?> get props => [status];
}
