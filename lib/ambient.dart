import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutwear/utils.dart';

class AmbientWatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new TimeDisplay(),
            new FlutterLogo(size: 50.0),
          ],
        ),
      ));
}

/// Displays the time at the creation of the widget
class TimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building TimeDisplay');
    return new Text(buildTime(),
        style: Theme
            .of(context)
            .textTheme
            .display1
            .copyWith(color: Colors.blueGrey, fontSize: 50.0));
  }
}

/// Displays the time, updating on an interval state by duration
class UpdatingTimeDisplay extends StatefulWidget {
  UpdatingTimeDisplay({@required this.interval});
  final Duration interval;

  @override
  createState() => new _UpdatingTimeDisplayState();
}

class _UpdatingTimeDisplayState extends State<UpdatingTimeDisplay> {
  String _timeStr;
  Timer _timer;

  @override
  initState() {
    super.initState();
    _timeStr = buildTime();
    _timer = Timer.periodic(
        widget.interval, (timer) => setState(() => _timeStr = buildTime()));
  }

  @override
  dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('UpdatingTimeDisplay build');
    return new Text(_timeStr,
        style: Theme
            .of(context)
            .textTheme
            .display1
            .copyWith(color: Colors.blueGrey));
  }
}
