import 'package:flutter/material.dart';

import 'package:flutwear/utils.dart';

class AmbientWatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimeDisplay(),
            const FlutterLogo(size: 50.0),
          ],
        ),
      ));
}

/// Displays the time at the creation of the widget
class TimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(buildTime(),
      style: Theme
          .of(context)
          .textTheme
          .display1
          .copyWith(color: Colors.blueGrey, fontSize: 50.0));
}
