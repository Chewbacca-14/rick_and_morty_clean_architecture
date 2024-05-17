import 'package:flutter/material.dart';
import 'package:rick_and_morty_clean_architecture/core/widgets/app_back_button.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/characters_page/characters_page.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/characters_page/characters_page_resources.dart';

class CharactersTabs extends StatefulWidget {
  const CharactersTabs({super.key});

  @override
  State<CharactersTabs> createState() => _CharactersTabsState();
}

class _CharactersTabsState extends State<CharactersTabs> {
  final CharactersPageResources _resources = CharactersPageResources();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Text(_resources.appBarText),
          bottom: TabBar(
            tabs: <Widget>[
              Text(_resources.tabBarAllText),
              Text(_resources.tabBarAliveText),
              Text(_resources.tabBarDeadText),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const CharactersPage(),
            CharactersPage(_resources.aliveQuery),
            CharactersPage(_resources.deadQuery),
          ],
        ),
      ),
    );
  }
}
