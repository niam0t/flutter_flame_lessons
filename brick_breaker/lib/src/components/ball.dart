import 'package:brick_breaker/src/brick_ball.dart';
import 'package:brick_breaker/src/components/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

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
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    final double left = 0, top = 0;
    final double right = game.width, bottom = game.height;

    if (other is PlayArea) {
      if (intersectionPoints.first.x <= left ||
          intersectionPoints.first.x >= right) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y <= top) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.y >= bottom) {
        removeFromParent();
        game.playState = .gameOver;
        add(RemoveEffect(delay: 0.35));
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
      velocity.x +=
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2 ||
          position.y > other.position.y + other.size.y) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x ||
          position.x > other.position.x) {
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier);
    } else {
      print("collision with $other");
    }
  }
}
