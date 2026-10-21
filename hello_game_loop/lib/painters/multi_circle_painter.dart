import 'package:hello_game_loop/models/circle.dart';
import 'package:material_ui/material_ui.dart';

class MultiCirclePainter({required final List<CircleModel> circles})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = Colors.primaries;
    final paint = Paint();

    for (var circle in circles) {
      // i = pointIndex % totalColor = i >= 0 & i < cLen
      paint.color = colors[circles.indexOf(circle) % colors.length];
      canvas.drawCircle(circle.offset, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MultiCirclePainter oldDelegate) {
    return oldDelegate.circles != circles;
  }
}
