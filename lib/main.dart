import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'birbz_game.dart';

Future<void> main() async {
  runApp(
    GameWidget(game: BirbzGame()),
  );
}
