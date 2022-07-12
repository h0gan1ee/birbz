import 'dart:math';

import 'package:flame/components.dart';

class BirdComponent extends RectangleComponent {
  BirdComponent({
    super.position,
    super.size,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
  }) : super() {
    _velocity = Vector2(
      preferredVelocity * sin(angle),
      -preferredVelocity * cos(angle),
    );
    _margin = size.length / 2;
  }
  // TODO: boid properties
  static const double vision = 260;
  static final num safeDistanceSquared = pow(8, 2);
  static const double preferredVelocity = 30;
  static const double maxVelocity = 80;
  static const double scale1 = 1 / 10;
  static const double scale2 = 1 / 4;
  static const double scale3 = 1 / 30;

  late Vector2 _velocity;
  Vector2? _nextVelocity;
  List<Neighbor> neighbors = [];
  late double _margin;

  void computeNext(final Vector2 screenSize, final Random random) {
    if (neighbors.isEmpty) {
      _nextVelocity = _velocity;
    } else {
      // rule 1: prefer to center of mass
      final center1 = neighbors.fold(
            Vector2.zero(),
            (final p, final e) => p + e.bird.position,
          ) *
          (1 / neighbors.length);
      final v1 = (center1 - position) * scale1;

      // rule 2: try to keep distance
      var v2 = Vector2.zero();
      for (var e in neighbors) {
        if (e.distanceSquared < safeDistanceSquared) {
          v2 += position - e.bird.position;
        }
      }
      v2 *= scale2;

      // rule 3: match neighbors' velocities
      final v3 = neighbors.fold(
              Vector2.zero(), (final p, final e) => p + e.bird._velocity) *
          (1 / neighbors.length) *
          scale3;

      _nextVelocity = _velocity + v1 + v2 + v3;

      _nextVelocity?.length *= 0.94 + 0.11 * random.nextDouble();

      // rule 4: must in constrain
      // if ((position.x < _margin && _nextVelocity!.x < 0) ||
      //     (position.x > screenSize.x - _margin &&
      //         _nextVelocity!.x > 0)) {
      //   _nextVelocity!.x = -_nextVelocity!.x;
      // }
      // if ((position.y < _margin && _nextVelocity!.y < 0) ||
      //     (position.y > screenSize.y - _margin &&
      //         _nextVelocity!.y > 0)) {
      //   _nextVelocity!.y = -_nextVelocity!.y;
      // }

      final lengthSquared = _nextVelocity!.length2;
      if (lengthSquared > pow(maxVelocity, 2)) {
        _nextVelocity!.length = maxVelocity;
      }
    }
  }

  void triggerUpdate(final double dt, final Vector2 screenSize) {
    neighbors.clear();
    _velocity = _nextVelocity!;
    position += _velocity * dt;
    position.x =
        (position.x + _margin) % (screenSize.x + 2 * _margin) - _margin;
    position.y =
        (position.y + _margin) % (screenSize.y + 2 * _margin) - _margin;
    final slop = _velocity.x / _velocity.y;
    angle = pi / 2 - atan(slop);
  }
}

class Neighbor {
  Neighbor(this.bird, this.distanceSquared);
  final BirdComponent bird;
  final double distanceSquared;
}
