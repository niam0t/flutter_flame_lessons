sealed class const Configs() {
  static double get width => 720;
  static double get height => 1600;

  static double get puddleHeight => width * .04;
  static double get puddleWidth => width * .2;
  static double get puddleRadius => puddleHeight / 2;
  static double get puddleStepSize => width * .15;

  static double get ballRadius => (width / height) * 30;
  static double get ballSpeed => width * 0.4;

  // static double get brickWidth => width * 0.05;
  static double get brickHeight => width * 0.05;
  static double get brickMinPadding => width * 0.005;
  static double get topPadding => Configs.brickHeight * 3;
}
