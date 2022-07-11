import 'dart:math';

import 'package:flame/game.dart';

import 'game_state.dart';

extension Vector2Extension on Vector2 {
  Vector2 half() => Vector2(x / 2, y / 2);
}
