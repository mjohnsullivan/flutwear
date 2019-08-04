import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nima/nima_actor.dart';
import 'package:wear/wear.dart';

import 'package:flutwear/widgets.dart';
import 'package:flutwear/utils.dart';

class HopCharacter extends StatefulWidget {
  @override
  createState() => _HopCharacterState();
}

class _HopCharacterState extends State<HopCharacter> {
  var _actionName = 'idle';
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
        Duration(seconds: 2),
        (_) => setState(() => DateTime.now().second < 2
            ? _actionName = 'attack'
            : _actionName = 'jump'));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final shape = InheritedShape.of(context).shape;
    final screenWidth = shape == Shape.round
        ? boxInsetLength(screenSize.width / 2)
        : screenSize.width;
    final screenHeight = shape == Shape.round
        ? boxInsetLength(screenSize.height / 2)
        : screenSize.height;
    return new Scaffold(
      body: Center(
        child: Container(
          //constraints:
          //    BoxConstraints(maxWidth: screenWidth, maxHeight: screenHeight),
          color: Colors.black,
          child: Stack(
            alignment: const Alignment(0.0, 0.9),
            children: [
              NimaActor('assets/hop.nima',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: _actionName,
                  mixSeconds: 0.5,
                  completed: (_) => setState(() => _actionName = 'idle')),
              TimeDisplay(fontSize: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
