import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../brick_ball.dart';
import 'components.dart';

class Ball({
  required final Vector2 velocity,
  required super.radius,
  required super.position,
  required final double difficultyModifier,
}) extends CircleComponent
    with HasGameReference<BrickBall>, CollisionCallbacks {
  this
    : super(
        anchor: Anchor.center,
        paint: Paint()
          ..color = Color(0xff1e6091)
          ..style = .fill,
        children: [CircleHitbox()],
      );

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlayArea) {
      if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
        if (velocity.x == 0) velocity.x++;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
        if (velocity.y == 0) velocity.y++;
      } else if (intersectionPoints.first.y >= game.height) {
        removeFromParent();
        game.playState = .gameOver;
        add(RemoveEffect(delay: 0.35));
      }
    }
    if (other is Bat) {
      velocity.y = -velocity.y;
      velocity.x +=
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    }
    if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2 ||
          position.y > other.position.y + other.size.y) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x ||
          position.x > other.position.x) {
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);
    }
    print("collision with $other");
  }
}
