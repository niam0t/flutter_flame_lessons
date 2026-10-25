import 'dart:async';

import 'package:brick_breaker/components/game_world.dart';
import 'package:brick_breaker/components/puddle.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/game.dart';

class BrickBreaker() extends FlameGame with HasCollisionDetection {
  this
    : super(
        camera: .withFixedResolution(
          width: Configs.width,
          height: Configs.height,
        ),
      );

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    camera.viewfinder.anchor = .topLeft;

    world.add(GameWorld());

    world.add(Puddle());

    // debugMode = true;
  }
}
