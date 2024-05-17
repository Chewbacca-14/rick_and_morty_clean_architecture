import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/usecases/fetch_episode.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_events.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_states.dart';

class EpisodeBloc extends Bloc<EpisodeEvents, EpisodeStates> {
  final FetchEpisode _fetchEpisode;

  EpisodeBloc({
    required FetchEpisode fetchEpisode,
  })  : _fetchEpisode = fetchEpisode,
        super(EpisodeLoadingState()) {
    List<Episode> episodes = [];
    on<FetchEpisodeData>((event, emit) async {
      emit(EpisodeLoadingState());
      try {
        Episode episode = await _fetchEpisode.call(url: event.url);
        if (episode == '') {
          emit(EpisodeEmptyState());
        } else {
          episodes.add(episode);
          emit(
            EpisodeSuccessState(episode: episodes),
          );
        }
      } catch (e) {
        emit(EpisodeErrorState('ERROR: $e'));
      }
    });
    on<ClearEpisodeList>((event, emit) {
      emit(EpisodeLoadingState());
      episodes.clear();
      emit(
        EpisodeSuccessState(episode: episodes),
      );
    });
  }
}
