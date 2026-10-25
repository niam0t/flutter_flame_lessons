import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flame/game.dart';
import 'package:meteor_shower/components/game_area.dart';
import 'package:meteor_shower/components/meteor.dart';

class MeteorShower() extends FlameGame with HasCollisionDetection {
  this : super(camera: .withFixedResolution(width: 720, height: 1600));
  double get width => size.x;
  double get height => size.y;
  double get meteorSize => width * 0.1;

  final rand = Random();

  @override
  void onLoad() {
    super.onLoad();

    camera.viewfinder.anchor = .topLeft;
    world.add(GameArea());

    startMeteorSpawnFactory();
  }

  void startMeteorSpawnFactory() {
    Future.doWhile(() async {
      await Future.delayed(rand.nextInt(2).clamp(0.2, 2).seconds, () async {
        world.add(
          Meteor(
            velocity: Vector2(
              0,
              (rand.nextInt((height / 12).toInt()))
                  .clamp(20, height / 4)
                  .toDouble(),
            )..normalized(),
            position: Vector2(rand.nextDouble() * width, 0),
            size: Vector2.all(meteorSize),
          ),
        );
      });
      return true;
    });
  }
}
