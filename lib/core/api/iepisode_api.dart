import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

abstract class IEpisodeApi {
  Future<Episode> fetchEpisodes({required String url});
}
