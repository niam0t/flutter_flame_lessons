import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyPlayer({var Vector2? velocity, super.position})
    extends RectangleComponent {
  this
    : super(
        size: Vector2.all(40),
        paint: Paint()..color = Colors.red,
        children: [RectangleComponent()],
      );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    velocity ??= .all(10);
    // add(MoveEffect.by(velocity!, EffectController(duration: 0.5)));
  }

  void moveAt({PlayerMoveDirection direction = .down, double speed = 1}) {
    assert(velocity != null);

    switch (direction) {
      case PlayerMoveDirection.left:
        position.x -= velocity!.x;
      case PlayerMoveDirection.right:
        position.x += velocity!.x;
      case PlayerMoveDirection.up:
        position.y -= velocity!.y;
      case PlayerMoveDirection.down:
        position.y += velocity!.y;
    }
  }
}

enum PlayerMoveDirection { left, right, up, down }
