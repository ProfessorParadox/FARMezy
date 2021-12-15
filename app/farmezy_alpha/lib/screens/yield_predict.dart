// custom form input screen code

import 'package:flutter/material.dart';
import '../widgets/yield_predict_form.dart';


import '../widgets/app_drawer.dart';

class YieldPredictFormScreen extends StatefulWidget {
  static const routeName = '/Yield-Predict-Screen';

  @override
  YieldPredictFormScreenState createState() => YieldPredictFormScreenState();
}

class YieldPredictFormScreenState extends State<YieldPredictFormScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Yield Prediction'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: YieldPredictForm(),
      ),
      drawer: AppDrawer(),
    );
  }
}
