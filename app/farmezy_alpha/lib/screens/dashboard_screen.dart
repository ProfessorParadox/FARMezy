// home screen containing column of feature screens links
// can use a grid builder for showing all screens

import 'package:flutter/material.dart';
import './crop_recommend.dart';
import './fertiliser_suggest.dart';
import './yield_predict.dart';
import './air_pollution.dart';
import './irrigation_logs.dart';
import './crop_vandalism.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dashboard body'),
            SizedBox(height: 50),
            // ElevatedButton(
            //   onPressed: () {
            //     createState() => FertiSuggestFormScreen();
            //   },
            //   child: Text('ferti suggest screen'),
            // ),
            SizedBox(height: 50),
            // Text('dashboard body'),
          ],
        ),
      ),
    );
  }
}
