// irrigation logs graphics display screen code

import 'package:flutter/material.dart';

class IrrigationLogsScreen extends StatelessWidget {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Irrigation Logs'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Text('Irrigation Logs Body'), //... builderfunc(),
      ),
    );
  }
}


/*
class IrrigationLogsScreen extends StatefulWidget {
  @required
  IrrigationLogsScreen createstate() => IrrigationLogsScreen();
}

class IrrigationLogsScreenState extends State<IrrigationLogsScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Irrigation Logs'),
      ),
      // body: Container(
      //   margin: EdgeInsets.all(24),
      //   child: //... builderfunc(),
      // ),
    );
  }
}
*/