import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:top_down_walker/components/my_camera.dart';
import 'package:top_down_walker/worlds/my_world.dart';

class MyGame() extends FlameGame with HasKeyboardHandlerComponents {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    world = MyWorld();
    camera = MyCamera();

    // debugMode = true;
  }
}
