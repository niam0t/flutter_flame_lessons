

sealed class const Configs() {
  static double get width => 720;
  static double get height => 1600;

  static double get puddleHeight => width * .04;
  static double get puddleWidth => width * .2;
  static double get puddleRadius => puddleHeight / 2;
}
