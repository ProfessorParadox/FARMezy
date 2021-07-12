// custom feature output screen code

import 'package:flutter/material.dart';

class YieldPredictRes extends StatefulWidget {
  // const YieldPredictRes({ Key? key }) : super(key: key);

  @override
  YieldPredictResState createState() => YieldPredictResState();
}

class YieldPredictResState extends State<YieldPredictRes> {
  int _result = 1967;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Predicted Yield for your plantation is: '),
            Text('$_result kilograms'),
          ],
        ), //... builderfunc(),
      ),
    );
  }
}
