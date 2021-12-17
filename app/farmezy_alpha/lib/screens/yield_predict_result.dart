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
    String _result = Provider.of<YieldData>(context, listen: false).yield;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Text(
              'Predicted Yield for your plantation is: ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${(double.parse(_result) * 98).toStringAsFixed(5)}. tonnes',
              style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
             ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.5,
                 decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/crop_yield.png'),
                              fit: BoxFit.cover),
                        ),
              ),
            ),
          ],
        ), //... builderfunc(),
      ),
      drawer: AppDrawer(),
    );
  }
}
