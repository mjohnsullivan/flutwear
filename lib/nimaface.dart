import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:nima/nima_actor.dart';

import 'package:flutwear/widgets.dart';

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

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (DateTime.now().second == 0) {
          _actionName = 'attack';
        } else {
          _actionName = 'jump';
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.0, 1.0),
      children: [
        NimaActor('assets/hop',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: _actionName, completed: (_) {
          print('Completed action $_actionName');
          setState(() => _actionName = 'idle');
        }),
        TimeDisplay(fontSize: 30.0),
      ],
    );
  }
}

/*
@override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: NimaActor('assets/hop',
              alignment: Alignment.bottomRight,
              fit: BoxFit.contain,
              animation: _actionName, completed: (_) {
            print('Completed action $_actionName');
            setState(() => _actionName = 'idle');
          }),
        ),
        TimeDisplay(),
      ],
    );
*/
