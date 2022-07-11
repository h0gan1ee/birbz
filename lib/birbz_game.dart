import 'dart:ui';

import 'package:birbz/game_theme.dart';
import 'package:birbz/vector2_extension.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BirbzGame extends FlameGame {
  static const String description = '''
    Birbz Game
  ''';

  final theme = GameTheme();

  @override
  final debugMode = true;

  @override
  backgroundColor() => theme.backgroundColor;

  @override
  Future<void> onLoad() async {
    add(TextComponent(
      text: 'Birbz Game',
      position: size.half(),
      anchor: Anchor.center,
    ));

    add(FpsTextComponent(
      scale: Vector2.all(theme.fpsTextScale),
      position: Vector2.all(20),
    ));
  }
}
