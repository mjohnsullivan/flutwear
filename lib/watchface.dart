import 'dart:math' show min;

import 'package:flutter/material.dart';

import 'package:wear/wear.dart';

import 'package:flutwear/widgets.dart';
import 'package:flutwear/utils.dart';

class WatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final shape = InheritedShape.of(context).shape;
    if (shape == Shape.round) {
      // boxInsetLength requires radius, so divide by 2
      screenSize = Size(boxInsetLength(screenSize.width / 2),
          boxInsetLength(screenSize.height / 2));
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Opacity(
                opacity: 0.3,
                child: FlutterLogo(
                    size: min(screenSize.width, screenSize.height))),
            PulseTime(
                style: Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

/// Pulses the scale of a time Text widget
class PulseTime extends StatefulWidget {
  PulseTime({this.style});
  final TextStyle style;

  @override
  createState() => PulseTimeState();
}

class PulseTimeState extends State<PulseTime>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  String _timeStr = buildTime(seconds: true);

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 1.0, end: 0.9).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        setState(() => _timeStr = buildTime(seconds: true));
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
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
    return Container(
      child: Center(
        child: ScaleTransition(
          scale: animation,
          child: Text(_timeStr, style: widget.style),
        ),
      ),
    );
  }
}
