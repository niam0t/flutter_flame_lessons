import 'dart:async';

import 'package:brick_breaker/brick_breaker.dart';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide PointerMoveEvent;

class Puddle({final Color color = Colors.brown})
    extends PositionComponent
    with HasGameReference<BrickBreaker>, DragCallbacks, CollisionCallbacks {
  this
    : super(
        anchor: .center,
        children: [RectangleHitbox()..isSolid = true],
        size: Vector2(Configs.puddleWidth, Configs.puddleHeight),
      );

  final _paint = Paint()..color = color;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ball) {
      if (intersectionPoints.first.y >= other.position.y) {
        other.velocity.y = -other.velocity.y.abs();
      }
      // else {
      //   game.world.remove(other);
      // }
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _moveBy(event.localDelta.x);
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

  void _moveBy(double x) {
    position.x += x;
    position.clampDouble(0, game.width, 0, position.y);
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    position = Vector2(game.width / 2, game.height * .96);

    add(
      KeyboardListenerComponent(
        keyDown: {
          .arrowLeft: (keysPressed) {
            _moveBy(-Configs.puddleStepSize);
            return false;
          },

          .arrowRight: (keysPressed) {
            _moveBy(Configs.puddleStepSize);
            return false;
          },
        },
      ),
    );
  }
}
