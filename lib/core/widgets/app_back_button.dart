import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.canPop()) {
          Navigator.pop(context);
        }
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
      ),
    );
  }
}
