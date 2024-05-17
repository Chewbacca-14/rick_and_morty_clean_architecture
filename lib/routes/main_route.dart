import 'package:flutter/material.dart';
import 'package:rick_and_morty_clean_architecture/router/routes.dart';
import 'package:rick_and_morty_clean_architecture/core/widgets/app_back_button.dart';
import 'package:go_router/go_router.dart';

class MainRoute extends StatelessWidget {
  const MainRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Rick and Morty"),
          leading: const AppBackButton(),
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '''
Rick And Morty Clean Architecture
''',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(RoutesInfo.charactersRouteInfo);
                  },
                  child: const Text('to characters'),
                ),
                const ElevatedButton(
                  onPressed: null,
                  child: Text('coming soon'),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
