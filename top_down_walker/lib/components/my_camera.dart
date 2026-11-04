import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_down_walker/components/my_player.dart';

class MyCamera() extends CameraComponent with KeyboardHandler {
  this
    : super(
        viewport: FixedResolutionViewport(
          resolution: .all(200),

          children: [
            RectangleComponent(
              size: Vector2.all(200),
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 1
                ..style = .stroke,
            ),
          ],
        ),
      );

  @override
  void update(double dt) {
    super.update(dt);

    final player = world?.children.query<MyPlayer>().firstOrNull;
    if (player != null) {
      follow(player);
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    if (event case final e when e is KeyDownEvent || e is KeyRepeatEvent) {
      if (keysPressed case final kp
          when kp.any((lk) => lk == .zoomIn || lk == .equal)) {
        zoomIn();
      } else if (keysPressed case final kp
          when kp.any((lk) => lk == .zoomOut || lk == .minus)) {
        zoomOut();
      }
    }
    return true;
  }

  double get _currentZoom => viewfinder.zoom;

  void zoomIn() => viewfinder.zoom = (_currentZoom + .2).clamp(.1, 1.5);
  void zoomOut() => viewfinder.zoom = (_currentZoom - .2).abs().clamp(.1, 2.0);
}
