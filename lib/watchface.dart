import 'dart:math' show min;

import 'package:flutter/material.dart';

import 'package:flutwear/wear.dart';
import 'package:flutwear/utils.dart';

class WatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final shape = InheritedShape.of(context).shape;
    if (shape == Shape.round) {
      screenSize = new Size(
          boxInsetLength(screenSize.width), boxInsetLength(screenSize.height));
    }

    return new Scaffold(
      body: new Center(
        child: new Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            new Opacity(
                opacity: 0.5,
                child: new FlutterLogo(
                    size: min(screenSize.width, screenSize.height))),
            new PulseTime(style: Theme.of(context).textTheme.display1),
          ],
        ),
      ),
    );
  }
}

class PulseTime extends StatefulWidget {
  PulseTime({this.style});
  final TextStyle style;

  @override
  createState() => new PulseTimeState();
}

/// Pulses the scale of a time Text widget
class PulseTimeState extends State<PulseTime>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  String _timeStr = buildTime(seconds: true);

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 1.0, end: 0.9).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        setState(() => _timeStr = buildTime(seconds: true));
      } else if (status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new ScaleTransition(
          scale: animation,
          child: new Text(_timeStr, style: widget.style),
        ),
      ),
    );
  }
}
