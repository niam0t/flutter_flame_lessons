import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyWorldView({super.size}) extends RectangleComponent {
  this
    : super(
        anchor: .center,
        paint: Paint()
          ..color = Colors.white
          ..strokeWidth = 10
          ..style = .stroke,
      );

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    super.size = size;
  }
}
