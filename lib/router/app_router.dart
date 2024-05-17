import 'package:rick_and_morty_clean_architecture/features/character_details/presentation/character_details_page.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/domain/models/character.dart';
import 'package:rick_and_morty_clean_architecture/router/paths.dart';
import 'package:rick_and_morty_clean_architecture/router/routes.dart';
import 'package:rick_and_morty_clean_architecture/routes/main_route.dart';
import 'package:rick_and_morty_clean_architecture/features/characters_page/presentation/characters_page/characters_tabs.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: RoutesInfo.mainRouteInfo,
    routes: [
      GoRoute(
        path: Paths.mainPath,
        builder: (context, state) => const MainRoute(),
      ),
      GoRoute(
        path: Paths.charactersPath,
        builder: (context, state) => const CharactersTabs(),
      ),
      GoRoute(
          path: Paths.charactersDetailsPath,
          builder: (context, state) {
            Character character = state.extra as Character;
            return CharacterDetailsPage(character: character);
          }),
    ],
  );
}
