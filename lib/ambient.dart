import 'package:flutter/material.dart';

import 'package:flutwear/widgets.dart';

class AmbientWatchFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
