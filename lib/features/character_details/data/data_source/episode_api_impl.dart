import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_clean_architecture/core/api/iepisode_api.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';

class EpisodeApiImpl implements IEpisodeApi {
  @override
  Future<Episode> fetchEpisodes({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        Episode episode = Episode.fromJson(jsonData);
        return episode;
      } else {
        print('Failed to load data');
        return Episode();
      }
    } catch (e) {
      print('[Fetch Episodes] $e');
      return Episode();
    }
  }
}
