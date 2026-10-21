import 'package:material_ui/material_ui.dart';

class CircleModel({
  var double x = 0,
  var double y = 0,
  var double velocity = 1,
  var double radius = 20,
}) {
  Offset get offset => Offset(x, y);

  void step(double dt) {
    x += velocity * dt;
    y += velocity * dt;
  }

  void mutWith({double? x, double? y}) {
    this.x = x ?? this.x;
    this.y = y ?? this.y;
    velocity = velocity;
  }

  void onWallHit(double maxX, double maxY) {
    // reset coords
    if (x - radius > maxX) {
      mutWith(x: 0 - radius); // only x
    }
    if (y - radius > maxY) {
      mutWith(y: 0 - radius); // only y
    }
  }

  @override
  String toString() {
    return "($x, $y)";
  }
}
