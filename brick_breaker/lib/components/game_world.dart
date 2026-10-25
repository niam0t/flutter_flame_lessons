import 'package:brick_breaker/brick_breaker.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameWorld()
    extends RectangleComponent
    with HasGameReference<BrickBreaker> {
  this
    : super(
        paint: Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
        anchor: .topLeft,
        size: Vector2(Configs.width, Configs.height),
      );
}
