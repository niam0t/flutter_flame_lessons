import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:hello_game_loop/models/circle.dart';
import 'package:hello_game_loop/widgets/multi_circle_viewer.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MainApp());
}

class const MainApp({super.key}) extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late final Ticker _ticker;
  var _lastElapsed = Duration.zero;
  List<CircleModel> _circleList = <CircleModel>[
    CircleModel(x: 5, y: 10, velocity: 2),
    CircleModel(x: 8, y: 15, velocity: 23),
    CircleModel(x: 2, y: 20, velocity: 24),
    CircleModel(x: 9, y: 18, velocity: 25),
  ];
  late double _maxX;
  late double _maxY;

  @override
  Widget build(BuildContext context) {
    return MultiCircleViewer(circles: _circleList, onTapAdd: _addNewCircle);
  }

  /// add new circle with rand coords and v
  void _addNewCircle() {
    final randGen = Random();
    final randX = randGen.nextInt(_maxX.toInt());
    final randY = randGen.nextInt(_maxY.toInt());
    final randV = randGen.nextInt(50);
    _circleList.add(
      CircleModel(
        x: randX.toDouble(),
        y: randY.toDouble(),
        velocity: randV.toDouble(),
      ),
    );
  }

  double _calcDtSecond(Duration elapsed) {
    // dt
    final dtDuration = elapsed - _lastElapsed; // (now - past) the time it took
    _lastElapsed = elapsed; // (past = now) temporary mark the moment

    final dtSeconds =
        dtDuration.inMicroseconds /
        Duration.microsecondsPerSecond; // Duration => Seconds

    return dtSeconds;
  }

  void _onEveryFrame(Duration elapsed) {
    final dt = _calcDtSecond(elapsed);

    // move with v
    for (var circle in _circleList) {
      circle.step(dt);
      circle.onWallHit(_maxX, _maxY);
    }
    _circleList = List.from(_circleList); //? inefficient

    // rebuild
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onEveryFrame);
    _ticker.start();
  }

  void _updateMaxXY() {
    final size = MediaQuery.sizeOf(context);
    _maxX = size.width;
    _maxY = size.height;
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMaxXY();
  }
}
