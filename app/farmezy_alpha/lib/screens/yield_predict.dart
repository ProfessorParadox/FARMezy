// custom form input screen code

import 'package:flutter/material.dart';
import '../widgets/yield_predict_form.dart';

class YieldPredictFormScreen extends StatefulWidget {
  @override
  YieldPredictFormScreenState createState() => YieldPredictFormScreenState();
}

class YieldPredictFormScreenState extends State<YieldPredictFormScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Yield Prediction'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: YieldPredictForm(),
      ),
    );
  }
}
