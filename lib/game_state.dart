import 'dart:math';

import 'package:birbz/vector2_extension.dart';

import "bird_component.dart";
import "int_extension.dart";
import 'package:flame/components.dart';

class GameState {
  // GameState(this.birdSprite);
  GameState();
  Random random = Random(); // TODO
  // Sprite birdSprite;
  List<BirdComponent> birds = [];

  factory GameState.fromRandom(final int birdCount, final Vector2 screenSize) {
    // var state = GameState(await Sprite.load('birb.png'));
    var state = GameState();
    birdCount.forEach((final _) {
      state.birds.add(BirdComponent(
        state.random,
        // sprite: state.birdSprite,
        position: screenSize.hadamardProduct(Vector2.random(state.random)),
        size: Vector2(10, 3),
        angle: 2 * pi * state.random.nextDouble(),
        // angle: pi / 6,
        anchor: Anchor.center,
      ));
    });
    return state;
  }

  void update(final double dt, final Vector2 screenSize) {
    birds.length.forEach((final i) {
      birds.length.forEach((final j) {
        if (i != j) {
          var a = birds[i];
          var b = birds[j];
          double distanceSquared = a.position.distanceToSquared(b.position);
          if (distanceSquared < BirdComponent.safeDistanceSquared) {
            a.neighbors.add(Neighbor(b, distanceSquared));
            b.neighbors.add(Neighbor(a, distanceSquared));
          }
        }
      });
    });
    for (final e in birds) {
      e.computeNext(screenSize, random);
    }
    for (final e in birds) {
      e.triggerUpdate(dt, screenSize);
    }
  }
}
