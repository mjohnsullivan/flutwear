import 'package:flutter/material.dart';

import 'package:flutwear/ambient.dart';
import 'package:flutwear/watchface.dart';
import 'package:flutwear/wear.dart';

void main() => runApp(WatchApp());

class WatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WatchScreen(),
      );
}

/// Manages the shape of the watch face and ambient mode
class WatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => WatchShape(
      builder: (context, shape) => InheritedShape(
          shape: shape,
          child: AmbientMode(
            builder: (context, mode) =>
                mode == Mode.active ? WatchFace() : AmbientWatchFace(),
          )));
}
