import 'package:flutter/material.dart';
import 'package:rick_and_morty_clean_architecture/app.dart';
import 'router/app_router.dart';

void main() {
  final router = AppRouter().router;

  runApp(
    App(
      router: router,
    ),
  );
}
