import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yield_predict_provider.dart';

import '../widgets/app_drawer.dart';
class YieldPredictRes extends StatefulWidget {
  static const routeName = '/yield-predict-result-screen';
  // const YieldPredictRes({ Key? key }) : super(key: key);

  @override
  YieldPredictResState createState() => YieldPredictResState();
}

class YieldPredictResState extends State<YieldPredictRes> {
 
  @override
  Widget build(BuildContext context) {
  String _result= Provider.of<YieldData>(context,listen: false).yield;
    return Scaffold(
       resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Predicted Yield for your plantation is: '),
            Text('${double.parse(_result)*980} kilograms'),
          ],
        ), //... builderfunc(),
      ),
      drawer: AppDrawer(),
    );
  }
}
