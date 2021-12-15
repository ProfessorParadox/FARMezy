import 'package:farmezy_alpha/providers/yield_predict_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../form_screen.dart';
import 'screens/dashboard_screen.dart';
import './providers/yield_predict_provider.dart';
import '../screens/crop_recommend.dart';
import '../screens/fertiliser_suggest.dart';
import '../screens/yield_predict.dart';
import '../screens/fertiliser_suggest_result.dart';
import '../screens/crop_recommend_result.dart';
import '../screens/yield_predict_result.dart';
import '../screens/crop_vandalism.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
    create: (ctx)=> YieldData(),
    child: MaterialApp(
      title: 'farmezy_alpha',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.black,
      ),
      home: // CropRecFormScreen(),
          // FertiSuggestFormScreen(),
        //  YieldPredictFormScreen(),
      // FertiSuggestRes(),
      // CropRecRes(),
      // YieldPredictRes(),
      // CropVandalismScreen(),
       //FormScreen(),
       DashboardScreen(),
      routes: {
        YieldPredictFormScreen.routeName: (ctx)=> YieldPredictFormScreen(),
        FertiSuggestFormScreen.routeName: (ctx)=> FertiSuggestFormScreen(),
        CropRecFormScreen.routeName: (ctx)=> CropRecFormScreen(),
        YieldPredictRes.routeName: (ctx)=>YieldPredictRes(),
        CropRecRes.routeName: (ctx)=>CropRecRes(),

      }
    ) );
  }
}
