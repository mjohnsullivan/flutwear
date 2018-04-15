import 'package:flutter/material.dart';

import 'package:flutwear/ambient.dart';
import 'package:flutwear/watchface.dart';
import 'package:flutwear/wear.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WatchApp(),
    );
  }
}

/// Explicitly listens for ambient updates from WearOS and
/// handles redrawing the ambient watch face
class WatchApp extends StatefulWidget {
  @override
  createState() => new _WatchAppState();
}

class _WatchAppState extends State<WatchApp> {
  Widget ambient;

  @override
  initState() {
    super.initState();
    _ambientUpdate();
  }

  _ambientUpdate() {
    setState(() => ambient = new AmbientWatchFace());
  }

  @override
  Widget build(BuildContext context) {
    return new WatchShape(
      square: new AmbientMode(
          child: new WatchFace(), ambient: ambient, update: _ambientUpdate),
      round: new AmbientMode(
          child: new WatchFace(), ambient: ambient, update: _ambientUpdate),
    );
  }
}
