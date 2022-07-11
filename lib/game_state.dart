import 'dart:math';

import 'package:birbz/int_extension.dart';
import 'package:birbz/vector2_extension.dart';
import 'package:flame/game.dart';

class GameState {
  Random random = Random(); // TODO
  List<BirdState> birds = [];

  GameState(int birdNum) {
    birdNum.forEach((_) => birds.add(
          BirdState(
            Vector2.random(random),
            orientation: Angle.fromTurns(random.nextDouble()),
          ),
        ));
  }
}

class BirdState {
  // TODO: boid properties
  static const double vision = 100;
  static final num safeDistanceSquared = pow(15, 2);
  static const double preferredVelocity = 5;
  static const double scale1 = 1 / 100;
  static const double scale2 = 1 / 8;

  Vector2 position; // range: [0, 1)
  late Vector2 velocity; // range: [0, 1)
  List<BirdState> neighbors = [];

  Vector2? _nextVelocity;

  BirdState(this.position, {Angle? orientation}) {
    orientation ??= Angle(0);
    velocity = Vector2(
      preferredVelocity * cos(orientation.angle),
      preferredVelocity * sin(orientation.angle),
    );
  }

  void computeNext() {
    // rule 1: prefer to center of mass
    final center1 = neighbors.fold(Vector2.zero(), (p, e) => p + e.position) *
        (1 / neighbors.length);
    final v1 = (center1 - position) * scale1;

    // rule 2: try to keep distance
    var v2 = Vector2.zero();
    neighbors.forEach((element) {
      if (position.distanceToSquared(element.position) > safeDistanceSquared) {
        v2 += position - element.position;
      }
    });

    // rule 3: match neighbors' velocities
    final v3 = (neighbors.fold(Vector2.zero(), (p, e) => p + e.velocity) *
                (1 / neighbors.length) -
            position) *
        scale2;

    _nextVelocity = velocity + v1 + v2 + v3;
  }

  void update() {
    assert(_nextVelocity != null);
    velocity = _nextVelocity!;
  }
}

class Angle {
  late double _angle; // in radians
  double get angle => _angle;
  set angle(double radians) => _angle = radians.abs() % (2 * pi);

  Angle(double radians) {
    angle = radians;
  }

  Angle.fromTurns(double turns) {
    angle = turns * 2 * pi;
  }
}
