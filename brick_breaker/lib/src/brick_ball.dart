import 'dart:async';
import 'dart:math';

import 'package:brick_breaker/src/components/components.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BrickBall()
    extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapCallbacks {
  this
    : super(
        camera: CameraComponent.withFixedResolution(
          width: Config.gameWidth,
          height: Config.gameHeight,
        ),
      );

  ValueNotifier<int> score = ValueNotifier(0);

  double get width => size.x;
  double get height => size.y;
  final rand = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    if (LogicalKeyboardKey.arrowLeft == event.logicalKey) {
      world.children.query<Bat>().first.moveBy(-Config.batStep);
    } else if (LogicalKeyboardKey.arrowRight == event.logicalKey) {
      world.children.query<Bat>().first.moveBy(Config.batStep);
    } else if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      startGame();
    }
    return .handled;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    startGame();
  }

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case .welcome:
      case .gameOver:
      case .won:
        overlays.add(playState.name);
      case .playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();
    return Color(0xfff2e8cf);
  }

  void startGame() {
    if (playState == .playing) return;

    world.removeAll(world.children.query<Ball>());
    // world.removeAll(world.children.query<Brick>());
    world.removeAll(world.children.query<Bat>());

    playState = .playing;
    score.value = 0;

    world.add(
      Ball(
        velocity: Vector2((rand.nextDouble() * 0.5) * width, height * 0.2)
          ..normalize()
          ..scale(height / 4),
        radius: 20,
        position: size / 2,
        difficultyModifier: Config.difficultyModifier,
      ),
    );
    world.add(
      Bat(
        cornerRadius: Radius.circular(Config.batRadius),
        size: Vector2(Config.batWidth, Config.batHeight),
        position: Vector2(width / 2, height * 0.96),
      ),
    );

    world.addAll([
      for (var i = 0; i < Config.brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * Config.brickWidth + (i + 1) * Config.brickGutter,
              (j + 2.0) * Config.brickHeight + j * Config.brickGutter,
            ),
            color: Config.brickColors[i],
          ),
    ]);
  }
}

enum PlayState { welcome, playing, gameOver, won }
