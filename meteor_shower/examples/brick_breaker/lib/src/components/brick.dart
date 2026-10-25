import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../brick_ball.dart';
import '../config.dart';
import 'components.dart';

class Brick({required final Color color, required super.position})
    extends RectangleComponent
    with HasGameReference<BrickBall>, CollisionCallbacks {
  this
    : super(
        size: Vector2(Config.brickWidth, Config.brickHeight),
        anchor: .center,
        paint: Paint()..color = color,
        children: [RectangleHitbox()],
      );
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++;
    if (game.world.children.query<Brick>().length == 1) {
      game.playState = .won;
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}
