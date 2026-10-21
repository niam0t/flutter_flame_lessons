import 'package:hello_game_loop/models/circle.dart';
import 'package:hello_game_loop/painters/multi_circle_painter.dart';
import 'package:material_ui/material_ui.dart';

class const MultiCircleViewer({
  required final List<CircleModel> circles,
  final VoidCallback? onTapAdd,
  super.key,
}) extends StatefulWidget {
  @override
  State<MultiCircleViewer> createState() => _MultiCircleViewerState();
}

class _MultiCircleViewerState extends State<MultiCircleViewer> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .ltr,
      child: Stack(
        children: [
          CustomPaint(painter: MultiCirclePainter(circles: widget.circles)),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton.filledTonal(
              onPressed: widget.onTapAdd,
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
