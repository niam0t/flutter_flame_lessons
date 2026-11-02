import 'dart:async';
import 'dart:math';

import 'package:brick_breaker/components/bricks.dart';
import 'package:brick_breaker/components/components.dart';
import 'package:brick_breaker/configs.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BrickBreaker()
    extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  this
    : super(
        camera: .withFixedResolution(
          width: Configs.width,
          height: Configs.height,
        ),
      );

  double get height => size.y;
  double get width => size.x;

  GameStatus? gameStatus;

  final rand = Random();

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    camera.viewfinder.anchor = .topLeft;

    world.add(GameWorld());

    _print('Tap on Space');

    // debugMode = true;
  }

  void startGame() {
    _cleanWorld();

    gameStatus = .playing;
    world.add(Puddle());
    world.add(Bricks());
    world.add(Ball());
  }

  void _cleanWorld() {
    gameStatus = .end;
    world.removeAll(world.children.query<Puddle>());
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bricks>());
    world.removeAll(world.children.query<TextBoxComponent>());
  }

  void onWin() {
    _cleanWorld();
    _print("You Won!");
  }

  void _print(String msg) {
    world.add(
      TextBoxComponent(
        text: msg,
        align: .center,
        position: Vector2(width / 2, height / 2),
        anchor: .center,
        boxConfig: .new(),
      ),
    );
  }

  void onLoose() {
    _cleanWorld();
    _print('You Lost!');
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    if (gameStatus != .playing && event.logicalKey == .space) {
      startGame();
    }
    return .handled;
  }
}

enum GameStatus { playing, end }
