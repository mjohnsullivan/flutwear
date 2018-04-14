import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutwear/ambient.dart';
import 'package:flutwear/watchface.dart';
import 'package:meta/meta.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new WatchFaceShape(
          squareChild: new AmbientMode(
              child: new WatchFace(), ambientChild: new AmbientWatchFace()),
          roundChild: new AmbientMode(
              child: new WatchFace(), ambientChild: new AmbientWatchFace()),
        ));
  }
}

enum Shape { square, round }

class WatchFaceShape extends StatefulWidget {
  WatchFaceShape({@required this.squareChild, @required this.roundChild});
  final Widget squareChild;
  final Widget roundChild;

  @override
  createState() => new _WatchFaceShapeState();
}

class _WatchFaceShapeState extends State<WatchFaceShape> {
  static const platform =
      const MethodChannel('com.mjohnsullivan.flutwear/shape');

  var shape = Shape.square;

  @override
  void initState() {
    super.initState();
    _getShape();
  }

  Future<Null> _getShape() async {
    Shape shape;
    try {
      final int result = await platform.invokeMethod('shape');
      shape = result == 1 ? Shape.square : Shape.round;
    } on PlatformException catch (e) {
      // Default to round
      print(e);
      shape = Shape.round;
    }

    setState(() {
      shape;
    });
  }

  @override
  Widget build(BuildContext context) =>
      shape == Shape.square ? widget.squareChild : widget.roundChild;
}
