import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutwear/utils.dart';

/// Displays the time at the creation of the widget
class TimeDisplay extends StatelessWidget {
  TimeDisplay({this.fontSize = 50.0});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    print('Rebuilding time display');
    return Text(buildTime(),
        style: Theme
            .of(context)
            .textTheme
            .display1
            .copyWith(color: Colors.blueGrey, fontSize: fontSize));
  }
}

/// Displays text with a shadow
class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 2.0,
            left: 2.0,
            child: Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
