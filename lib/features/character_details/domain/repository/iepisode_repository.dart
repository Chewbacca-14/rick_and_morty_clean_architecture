import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

abstract class IEpisodeRepository {
  Future<Episode> fetchEpisode({required String url});
}
