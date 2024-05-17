import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/core/api/icharacter_api.dart';
import 'package:rick_and_morty_clean_architecture/core/api/iepisode_api.dart';
import 'package:rick_and_morty_clean_architecture/core/api/ilocation_api.dart';
import 'package:rick_and_morty_clean_architecture/core/data/data_source/location_api_impl.dart';
import 'package:rick_and_morty_clean_architecture/core/data/repository/location_repository_impl.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/repository/ilocation_repository.dart';
import 'package:rick_and_morty_clean_architecture/core/domain/usecases/fetch_locations.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/data/data_source/episode_api_impl.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/data/repository/episode_repository_impl.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/repository/iepisode_repository.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/usecases/fetch_episode.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/data/repository_impl/character_repository_impl.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/data/data_source/character_api_impl.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/repository/character_repository.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/usecases/fetch_characters.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  final GoRouter router;

  const App({
    required this.router,
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late FetchCharacters fetchCharacters;
  late FetchEpisode fetchEpisode;
  late FetchLocations fetchLocation;

  @override
  void initState() {
    super.initState();
    //Character
    ICharacterApi api = CharacterApiImpl();
    ICharacterRepository repository = CharacterRepositoryImpl(api: api);
    fetchCharacters = FetchCharacters(repository: repository);

    //Episode
    IEpisodeApi episodeApi = EpisodeApiImpl();
    IEpisodeRepository episodeRepository =
        EpisodeRepositoryImpl(api: episodeApi);
    fetchEpisode = FetchEpisode(repository: episodeRepository);

    //Location
    ILocationApi locationApi = LocationApiImpl();
    ILocationRepository locationRepository =
        LocationRepositoryImpl(api: locationApi);
    fetchLocation = FetchLocations(repository: locationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) => CharacterBloc(fetchCharacters: fetchCharacters),
        ),
        BlocProvider<EpisodeBloc>(
          create: (context) => EpisodeBloc(fetchEpisode: fetchEpisode),
        ),
        BlocProvider<LocationsBloc>(
          create: (context) => LocationsBloc(fetchLocations: fetchLocation),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: widget.router.routeInformationParser,
        routeInformationProvider: widget.router.routeInformationProvider,
        routerDelegate: widget.router.routerDelegate,
      ),
    );
  }
}
