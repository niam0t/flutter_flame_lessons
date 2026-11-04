import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:top_down_walker/components/my_camera.dart';
import 'package:top_down_walker/my_game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      debugShowCheckedModeBanner: false,
      home: MyGameApp(),
      pageRouteBuilder: <T>(settings, builder) {
        return PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, _, _) => builder(context),
        );
      },
      color: Colors.black,
    );
  }
}

class MyGameApp extends StatefulWidget {
  const MyGameApp({super.key});

  @override
  State<MyGameApp> createState() => _MyGameAppState();
}

class _MyGameAppState extends State<MyGameApp> {
  late OverlayEntry overlayEntry;
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: myGame));
  }

  @override
  void initState() {
    super.initState();

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          right: 0,
          child: Column(
            children: [
              IconButton.outlined(
                onPressed: _onZoomIn,
                icon: Icon(Icons.zoom_in, color: Colors.white),
              ),

              IconButton.outlined(
                onPressed: _onZoomOut,
                icon: Icon(Icons.zoom_out, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    overlayEntry.dispose();
    super.dispose();
  }

  void _onZoomIn() {
    final myCamera = myGame.children.query<MyCamera>().firstOrNull;
    if (myCamera != null) {
      myCamera.zoomIn();
    }
  }

  void _onZoomOut() {
    final myCamera = myGame.children.query<MyCamera>().firstOrNull;
    if (myCamera != null) {
      myCamera.zoomOut();
    }
  }
}
