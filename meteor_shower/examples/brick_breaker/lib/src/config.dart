import 'dart:ui';

sealed class const Config() {
  static const double gameWidth = 820.0;
  static const double gameHeight = 1600.0;

  static const double ballRadius = gameWidth * 0.02;

  static const double batWidth = gameWidth * 0.2;
  static const double batHeight = ballRadius * 2;
  static const double batStep = gameWidth * 0.05;
  static const double batRadius = gameWidth * 0.02;

  static const brickColors = [
    Color(0xfff94144),
    Color(0xfff3722c),
    Color(0xfff8961e),
    Color(0xfff9844a),
    Color(0xfff9c74f),
    Color(0xff90be6d),
    Color(0xff43aa8b),
    Color(0xff4d908e),
    Color(0xff277da1),
    Color(0xff577590),
  ];
  static const brickGutter = gameWidth * 0.015;
  static final brickWidth =
      (gameWidth - (brickGutter * (brickColors.length + 1))) /
      brickColors.length;
  static const brickHeight = gameHeight * 0.03;
  static const difficultyModifier = 1.03;
}
