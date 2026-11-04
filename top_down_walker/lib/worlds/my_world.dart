import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:top_down_walker/components/my_player.dart';
import 'package:top_down_walker/components/my_world_view.dart';

class MyWorld() extends World with KeyboardHandler, HasGameReference {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(MyPlayer());
    add(MyWorldView(size: game.size));
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (keysPressed case final kp
          when kp.any((lk) => lk == .keyA || lk == .arrowLeft || lk == .keyH)) {
        children.query<MyPlayer>().first.moveAt(direction: .left);
      }
      if (keysPressed case final kp
          when kp.any(
            (lk) => lk == .arrowRight || lk == .keyD || lk == .keyL,
          )) {
        children.query<MyPlayer>().first.moveAt(direction: .right);
      }
      if (keysPressed case final kp
          when kp.any((lk) => lk == .arrowUp || lk == .keyW || lk == .keyK)) {
        children.query<MyPlayer>().first.moveAt(direction: .up);
      }
      if (keysPressed case final kp
          when kp.any((lk) => lk == .arrowDown || lk == .keyS || lk == .keyJ)) {
        children.query<MyPlayer>().first.moveAt(direction: .down);
      }
    }

    return true;
  }
}
