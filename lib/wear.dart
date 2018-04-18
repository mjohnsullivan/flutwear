import 'package:flutter/services.dart';

/// Receives messages that determines if the watch is in full power or
/// ambient mode and renders the appropriate widget for that mode

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Shape of a watch
enum Shape { square, round }

/// Method channel for retrieving the watch face shape
const shapePlatform = const MethodChannel('com.mjohnsullivan.flutwear/shape');

/// Fetches the shape of the watch face
Future<Shape> _getShape() async {
  try {
    final int result = await shapePlatform.invokeMethod('shape');
    return result == 1 ? Shape.square : Shape.round;
  } on PlatformException catch (e) {
    // Default to round
    print('Error detecting shape: $e');
    return Shape.round;
  }
}

/// Widget that's aware of whether a watch is in full power or ambient mode,
/// and renders the appropriate child for each mode. Optionally takes an
/// update function that's called every time the watch triggers an ambient
/// update.
class AmbientMode extends StatefulWidget {
  AmbientMode({@required this.ambient, @required this.child, this.update});
  final Widget ambient;
  final Widget child;
  final Function update;

  @override
  createState() => new _AmbientState();
}

class _AmbientState extends State<AmbientMode> {
  static const platformAmbient =
      const MethodChannel('com.mjohnsullivan.flutwear/ambient');

  bool inAmbient = false;

  @override
  initState() {
    super.initState();

    platformAmbient.setMethodCallHandler((call) {
      switch (call.method) {
        case 'enter':
          print('Entering ambient');
          setState(() => inAmbient = true);
          break;
        case 'update':
          print('Updating ambient');
          widget.update();
          if (!inAmbient) setState(() => inAmbient = true);
          break;
        case 'exit':
          print('Exiting ambient');
          setState(() => inAmbient = false);
          break;
        default:
          print('Unknown message');
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      inAmbient ? widget.ambient : widget.child;
}

/// Build child widget depending on the watch shape (square or round).
/// Defaults to round if unable to determine the shape
class WatchShape extends StatefulWidget {
  WatchShape({@required this.square, @required this.round});
  final Widget square;
  final Widget round;

  @override
  createState() => new _WatchShapeState();
}

class _WatchShapeState extends State<WatchShape> {
  var shape = Shape.round;

  @override
  void initState() {
    super.initState();
    _getShape();
  }

  _getShape() async {
    Shape shape;
    try {
      final int result = await shapePlatform.invokeMethod('shape');
      shape = result == 1 ? Shape.square : Shape.round;
    } on PlatformException catch (e) {
      // Default to round
      print('Error detecting shape: $e');
      shape = Shape.round;
    }

    setState(() {
      this.shape = shape;
    });
  }

  @override
  Widget build(BuildContext context) => new InheritedShape(
      shape: shape,
      child: shape == Shape.square ? widget.square : widget.round);
}

/// An inherited widget that holds the shape of the Watch
class InheritedShape extends InheritedWidget {
  const InheritedShape({Key key, @required this.shape, @required Widget child})
      : assert(shape != null),
        assert(child != null),
        super(key: key, child: child);

  final Shape shape;

  static InheritedShape of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedShape);
  }

  @override
  bool updateShouldNotify(InheritedShape old) => shape != old.shape;
}

/// Builds a child for a WatchFaceBuilder
typedef Widget WatchShapeWidgetBuilder(
  BuildContext context,
  Shape shape,
);

/// Builder widget for watch shapes
class WatchShapeBuilder extends StatefulWidget {
  WatchShapeBuilder({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);
  final WatchShapeWidgetBuilder builder;

  @override
  createState() => new _WatchShapeBuilderState();
}

class _WatchShapeBuilderState extends State<WatchShapeBuilder> {
  Shape shape;

  @override
  void initState() {
    super.initState();
    // Default to round until the platform returns the shape
    // round being the most common form factor for WearOS
    shape = Shape.round;
    _setShape();
  }

  /// Sets the watch face shape
  _setShape() async {
    shape = await _getShape();
    setState(() => shape);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, shape);
}
