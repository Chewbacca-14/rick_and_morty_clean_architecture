import 'package:rick_and_morty_clean_architecture/features/character_details/domain/repository/iepisode_repository.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

class FetchEpisode {
  FetchEpisode({
    required IEpisodeRepository repository,
  }) : _repository = repository;

  final IEpisodeRepository _repository;

  Future<Episode> call({required String url}) async {
    final episode = await _repository.fetchEpisode(url: url);
    return episode;
  }
}
