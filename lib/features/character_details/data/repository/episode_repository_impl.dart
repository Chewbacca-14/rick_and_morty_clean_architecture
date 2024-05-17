import 'package:rick_and_morty_clean_architecture/core/api/iepisode_api.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/repository/iepisode_repository.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

class EpisodeRepositoryImpl implements IEpisodeRepository {
  final IEpisodeApi _api;
  EpisodeRepositoryImpl({
    required IEpisodeApi api,
  }) : _api = api;

  @override
  Future<Episode> fetchEpisode({required String url}) async {
    final episode = await _api.fetchEpisodes(url: url);
    return episode;
  }
}
