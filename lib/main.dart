import 'package:birbz/birbz_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    GameWidget(game: BirbzGame()),
  );
}
