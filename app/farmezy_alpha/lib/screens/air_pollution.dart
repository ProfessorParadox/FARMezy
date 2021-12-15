// air pollution levels display screen code

import 'package:flutter/material.dart';

class AirPollutionScreen extends StatelessWidget {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Air Pollution Levels'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Text('Air Pollution Levels Body'), //... builderfunc(),
      ),
    );
  }
}


/*
class AirPollutionScreen extends StatefulWidget {
  @required
  AirPollutionScreen createstate() => AirPollutionScreen();
}

class AirPollutionScreenState extends State<AirPollutionScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air Pollution Levels'),
      ),
      // body: Container(
      //   margin: EdgeInsets.all(24),
      //   child: //... builderfunc(),
      // ),
    );
  }
}
*/