import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:meteor_shower/meteor_shower.dart';

class Meteor({
  required final Vector2 velocity,
  required super.position,
  required super.size,
}) extends PositionComponent with HasGameReference<MeteorShower> {
  this : super(anchor: .center, angle: -pi / 4);

  late final SpriteComponent sprite;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = SpriteComponent(sprite: await Sprite.load('a.png'), size: size);
    add(sprite);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.y >= (game.height + game.meteorSize)) {
      removeFromParent();
    } else if (position.x >= game.width) {
      position.x -= game.meteorSize;
    } else if (position.x <= 0) {
      position.x += game.meteorSize;
    }
  }
}
