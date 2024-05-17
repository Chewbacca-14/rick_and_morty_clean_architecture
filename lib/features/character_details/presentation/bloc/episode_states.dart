import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

sealed class EpisodeStates {}

class EpisodeErrorState extends EpisodeStates {
  final String? errorMessage;
  EpisodeErrorState(this.errorMessage);
}

class EpisodeEmptyState extends EpisodeStates {}

class EpisodeLoadingState extends EpisodeStates {}

class EpisodeSuccessState extends EpisodeStates {
  List<Episode> episode;
  EpisodeSuccessState({required this.episode});
}
