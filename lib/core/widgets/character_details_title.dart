import 'package:flutter/material.dart';

class CharacterDetailsTitle extends StatelessWidget {
  final String title;
  const CharacterDetailsTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: Colors.red),
    );
  }
}
