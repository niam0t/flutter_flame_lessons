import 'dart:async';

import 'package:brick_breaker/src/brick_ball.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

class PlayArea() extends RectangleComponent with HasGameReference<BrickBall> {
  this
    : super(
        paint: Paint()..color = const Color(0xfff2e8cf),
        children: [RectangleHitbox()],
      );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
