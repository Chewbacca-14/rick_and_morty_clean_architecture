import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_bloc.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_events.dart';
import 'package:rick_and_morty_clean_architecture/core/presentation/locations_states.dart';
import 'package:rick_and_morty_clean_architecture/core/widgets/app_back_button.dart';
import 'package:rick_and_morty_clean_architecture/core/widgets/character_details_title.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/domain/models/episode.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_events.dart';
import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/bloc/episode_states.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:intl/intl.dart';

class CharacterDetailsPage extends StatefulWidget {
  final Character character;
  const CharacterDetailsPage({
    super.key,
    required this.character,
  });

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    getEpisodesAndLocations();
  }

  void getEpisodesAndLocations() {
    EpisodeBloc episodeBloc = BlocProvider.of<EpisodeBloc>(context);
    LocationsBloc locationBloc = BlocProvider.of<LocationsBloc>(context);
    for (String episode in widget.character.episode) {
      episodeBloc.add(
        FetchEpisodeData(
          url: episode,
        ),
      );
    }
    episodeBloc.add(
      ClearEpisodeList(),
    );
    locationBloc.add(
      FetchLocationsData(
        url: widget.character.location.url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      widget.character.image,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const CharacterDetailsTitle(title: 'Name'),
                  Text(
                    widget.character.name,
                  ),
                  const SizedBox(height: 10),
                  widget.character.type != ''
                      ? Column(
                          children: [
                            const CharacterDetailsTitle(title: 'Type'),
                            Text(
                              widget.character.type,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  const CharacterDetailsTitle(title: 'Species'),
                  Text(
                    widget.character.species,
                  ),
                  const SizedBox(height: 10),
                  const CharacterDetailsTitle(title: 'Location'),
                  Text(
                    '${widget.character.location.name}',
                  ),
                  const SizedBox(height: 10),
                  const CharacterDetailsTitle(title: 'List of episodes'),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.character.episode.length,
                    itemBuilder: (context, index) {
                      String episode = widget.character.episode[index];
                      return Text(episode);
                    },
                  ),
                  const CharacterDetailsTitle(title: 'episodes info'),
                  BlocBuilder<EpisodeBloc, EpisodeStates>(
                      builder: (context, state) {
                    return BlocBuilder<EpisodeBloc, EpisodeStates>(
                      builder: (context, state) {
                        switch (state) {
                          case EpisodeLoadingState():
                            return const Center(
                                child: CircularProgressIndicator());
                          case EpisodeErrorState():
                            return Center(
                                child: Text(
                                    '${(state).errorMessage}'));
                          case EpisodeEmptyState():
                            return const Center(
                                child: Text('Hmm. List is empty'));
                          case EpisodeSuccessState():
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.episode.length,
                              itemBuilder: (context, index) {
                                Episode episode = state.episode[index];
                                DateTime dateTime =
                                    DateTime.parse(episode.created!);
                                String formattedDateTime =
                                    DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(dateTime);
                                return ListTile(
                                  title: Text(episode.name ?? '-'),
                                  subtitle: Text(
                                      '${episode.episode ?? '-'} $formattedDateTime'),
                                );
                              },
                            );
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  const CharacterDetailsTitle(title: 'location info'),
                  BlocBuilder<LocationsBloc, LocationsState>(
                      builder: (context, state) {
                    switch (state) {
                      case LocationsLoadingState():
                        return const Center(child: CircularProgressIndicator());
                      case LocationsErrorState():
                        return Center(child: Text('${state.errorMessage}'));
                      case LocationsEmptyState():
                        return const Center(child: Text('Hmm. List is empty'));
                      case LocationsSuccessState():
                        final locationState = state;
                        return ListTile(
                          title: Text('Name: ${locationState.location.name}'),
                          subtitle: Text(
                              'Dimension: ${locationState.location.dimension} - Type: ${locationState.location.type}'),
                        );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
