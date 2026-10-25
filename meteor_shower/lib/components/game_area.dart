import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:material_ui/material_ui.dart';
import 'package:meteor_shower/meteor_shower.dart';

class GameArea()
    extends RectangleComponent
    with HasGameReference<MeteorShower> {
  this
    : super(
        paint: Paint()..color = Colors.black87,
        children: [RectangleHitbox()],
      );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
