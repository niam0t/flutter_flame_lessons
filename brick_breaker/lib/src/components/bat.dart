import 'dart:ui';

import 'package:brick_breaker/src/brick_ball.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

class Bat({
  required final Radius cornerRadius,
  required super.size,
  required super.position,
}) extends PositionComponent with HasGameReference<BrickBall>, DragCallbacks {
  this : super(children: [RectangleHitbox()], anchor: .center);

  final _paint = Paint()..color = Color(0xff1e6091);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size.toSize(), cornerRadius),
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }

  void moveBy(double dx) {
    add(
      MoveToEffect(
        Vector2((position.x + dx).clamp(0, game.width), position.y),
        EffectController(duration: 0.1),
      ),
    );
  }
}
