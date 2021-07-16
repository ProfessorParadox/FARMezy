import 'package:flutter/material.dart';
import './form_screen.dart';
import 'screens/dashboard_screen.dart';
import './screens/crop_recommend.dart';
import './screens/fertiliser_suggest.dart';
import './screens/yield_predict.dart';
import './screens/fertiliser_suggest_result.dart';
import './screens/crop_recommend_result.dart';
import './screens/yield_predict_result.dart';
import './screens/crop_vandalism.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'farmezy_alpha',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.lime,
      ),
      home: // CropRecFormScreen(),
          // FertiSuggestFormScreen(),
        //  YieldPredictFormScreen(),
      // FertiSuggestRes(),
      // CropRecRes(),
      // YieldPredictRes(),
      // CropVandalismScreen(),
       FormScreen(),
      // DashboardScreen(),
      routes: {
        YieldPredictFormScreen.routeName: (ctx)=> YieldPredictFormScreen(),
        FertiSuggestFormScreen.routeName: (ctx)=> FertiSuggestFormScreen(),
        CropRecFormScreen.routeName: (ctx)=> CropRecFormScreen(),

      }
    );
  }
}
