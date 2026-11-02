import 'dart:async';

import 'package:brick_breaker/brick_breaker.dart';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bricks({final int col = 10, final int row = 10})
    extends RectangleComponent
    with HasGameReference<BrickBreaker> {
  this
    : super(
        children: [RectangleHitbox()],
        position: Vector2(0, Configs.topPadding),
      );

  late int _brickRemains;
  void onRemoveBrick() {
    _brickRemains--;

    if (_brickRemains <= 0) {
      game.onWin();
    }
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    _brickRemains = col * row;
    _addBricks();
  }

  void _addBricks() {
    final brickHeight = Configs.brickHeight;
    final minPadding = Configs.brickMinPadding;

    final brickWidth = (game.width - (col + 1) * minPadding) / col;
    final padBetween = (game.width - col * brickWidth) / (col + 1);

    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        add(
          _Brick(
            size: Vector2(brickWidth, brickHeight),
            position: Vector2(
              padBetween + c * (brickWidth + padBetween),
              padBetween + r * (brickHeight + padBetween),
            ),
          ),
        );
      }
    }
  }
}

enum _Side { top, bottom, left, right }

class _Brick({
  required super.size,
  required super.position,
  final Color color = Colors.purple,
}) extends RectangleComponent with CollisionCallbacks, HasWorldReference {
  this : super(children: [RectangleHitbox()], paint: Paint()..color = color);

  @override
  void onRemove() {
    super.onRemove();
    if (world.children.query<Bricks>().isNotEmpty) {
      world.children.query<Bricks>().first.onRemoveBrick();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Ball) {
      final side = _sideOf(intersectionPoints);

      switch (side) {
        case .top:
          other.velocity.y = -other.velocity.y.abs();
        case .bottom:
          other.velocity.y = other.velocity.y.abs();
        case .left:
          other.velocity.x = -other.velocity.x.abs(); // force leftward
        case .right:
          other.velocity.x = other.velocity.x.abs(); // force rightward
      }
      removeFromParent();
    }
  }

  _Side _sideOf(Set<Vector2> points) {
    final mid = points.reduce((a, b) => a + b) / points.length.toDouble();
    final v = mid - absoluteCenter;

    if (v.x.abs() > v.y.abs()) {
      return v.x > 0 ? _Side.right : _Side.left;
    }
    return v.y > 0 ? _Side.bottom : _Side.top;
  }
}
