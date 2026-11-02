import 'dart:async';
import 'dart:math';

import 'package:brick_breaker/brick_breaker.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Ball() extends CircleComponent with HasGameReference<BrickBreaker> {
  this
    : super(
        position: Vector2(
          Random().nextDoubleBetween(Configs.width * 0.2, Configs.width * 0.8),
          Random().nextDoubleBetween(Configs.height / 3, Configs.height / 2),
        ),
        radius: Configs.ballRadius,
        anchor: .center,
        children: [CircleHitbox(radius: Configs.ballRadius, isSolid: true)],
        paint: Paint()
          ..color = Colors.white
          ..style = .fill,
      );

  late final Vector2 velocity;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    velocity = Vector2(
      Random().nextDoubleBetween(-Configs.ballSpeed, Configs.ballSpeed),
      Configs.height * 0.2,
    );
  }

  @override
  void onRemove() {
    super.onRemove();
    if (game.world.children.query<Ball>().isEmpty) {
      game.onLoose();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // check collision
    // left wall
    if (position.x <= Configs.ballRadius) {
      velocity.x = -velocity.x;
    }
    // right wall
    else if (position.x >= game.width - Configs.ballRadius) {
      velocity.x = -velocity.x;
    }

    //top wall
    if (position.y <= Configs.ballRadius) {
      velocity.y = -velocity.y;
    }
    //bottom wall
    else if (position.y >= game.height - Configs.ballRadius) {
      removeFromParent();
    }

    // fix overflows
    position.clampDouble(
      Configs.ballRadius,
      game.width - Configs.ballRadius,
      Configs.ballRadius,
      game.height - Configs.ballRadius,
    );

    // step
    position += velocity * dt;
  }
}
