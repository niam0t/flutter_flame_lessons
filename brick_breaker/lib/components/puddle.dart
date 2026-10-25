import 'dart:async';

import 'package:brick_breaker/brick_breaker.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Puddle({final Color color = Colors.brown})
    extends PositionComponent
    with HasGameReference<BrickBreaker>, DragCallbacks {
  this : super(anchor: .center, children: [RectangleHitbox()]);

  final _paint = Paint()..color = color;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (position.x < 0) {
      position.x = 0;
    } else if (position.x > game.width) {
      position.x = game.width;
    }

    position.x += event.localDelta.x;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      .fromRectAndRadius(
        Offset.zero & size.toSize(),
        Radius.circular(Configs.puddleRadius),
      ),
      _paint,
    );
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    position = Vector2(game.width / 2, game.height * .96);
    size = Vector2(Configs.puddleWidth, Configs.puddleHeight);
  }
}
