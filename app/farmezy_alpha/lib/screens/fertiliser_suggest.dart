// custom form input screen code
// -- see how to pass values

import 'package:flutter/material.dart';
import '../widgets/fertiliser_suggest_form.dart';


import '../widgets/app_drawer.dart';

class FertiSuggestFormScreen extends StatefulWidget {
  static const routeName = '/Ferilizer-Suggest-Screen';
  @override
  FertiSuggestFormScreenState createState() => FertiSuggestFormScreenState();
}

class FertiSuggestFormScreenState extends State<FertiSuggestFormScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fertiliser Suggestion'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: FertiSuggestForm(),
      ),
      drawer: AppDrawer(),
    );
  }
}
