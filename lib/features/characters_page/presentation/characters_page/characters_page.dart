import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_events.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/bloc/character_states.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/characters_page/characters_page_resources.dart';
import 'package:rick_and_morty_clean_architecture/core/widgets/item.dart';
import 'package:rick_and_morty_clean_architecture/router/routes.dart';
import 'package:go_router/go_router.dart';

class CharactersPage extends StatefulWidget {
  final String? status;

  // ignore: use_key_in_widget_constructors
  const CharactersPage([this.status]);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharactersPageResources _resources = CharactersPageResources();

  @override
  void initState() {
    super.initState();
    CharacterBloc characterBloc = BlocProvider.of<CharacterBloc>(context);
    characterBloc.add(FetchCharacterData(widget.status));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CharacterBloc, CharacterStates>(
          builder: (context, state) {
            switch (state) {
              case CharacterLoadingState():
                return const Center(child: CircularProgressIndicator());
              case CharacterErrorState():
                return Center(child: Text('${state.errorMessage}'));
              case CharacterEmptyState():
                return Center(child: Text(_resources.emptyListText));
              case CharacterSuccessState():
                return Padding(
                  padding: _resources.bodyPadding.copyWith(top: 40),
                  child: ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      Character character = state.characters[index];

                      return Item(
                        name: character.name,
                        status: character.status,
                        gender: character.gender,
                        lastLocation: '${character.location.name}',
                        onTap: () {
                          GoRouter.of(context).push(
                              RoutesInfo.charactersDetailsRouteInfo,
                              extra: character);
                        },
                      );
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
