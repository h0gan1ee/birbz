import 'package:flame/game.dart';

extension Vector2Extension on Vector2 {
  Vector2 half() => Vector2(x / 2, y / 2);
  Vector2 hadamardProduct(final Vector2 arg) => Vector2(x * arg.x, y * arg.y);
}
