import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Loggin you IN",style: TextStyle(color: Colors.purple[800] ,fontSize: 30,fontWeight: FontWeight.bold),)
              ],
            ),),
      
    );
  }
}