import "dart:ui";

import 'package:flame/game.dart';

import 'game_state.dart';
import 'game_theme.dart';

class BirbzGame extends FlameGame {
  static const String description = '''
    Birbz Game
  ''';

  final GameTheme theme = GameTheme();
  // var rectangle = RectangleComponent(
  //   position: Vector2.all(200),
  //   size: Vector2.all(100),
  //   anchor: Anchor.center,
  // );
  late GameState state;

  // @override
  // final bool debugMode = true;

  @override
  Color backgroundColor() => theme.backgroundColor;

  @override
  Future<void> onLoad() async {
    // add(TextComponent(
    //   text: 'Birbz Game',
    //   position: size.half(),
    //   anchor: Anchor.center,
    // ));
    state = await GameState.fromRandom(50, size);

    // add(FpsTextComponent(
    //   scale: Vector2.all(theme.fpsTextScale),
    //   position: Vector2.all(20),
    // ));

    // add(rectangle);

    for (var e in state.birds) {
      await add(e);
    }
  }

  @override
  void update(final double dt) {
    // rectangle.angle += 5 * dt;
    // if (rectangle.x > size.x + rectangle.size.length / 2) {
    //   rectangle.x = -rectangle.size.length;
    // }
    // rectangle.x += 140 * dt;
    state.update(dt, size);
    super.update(dt);
  }
}
