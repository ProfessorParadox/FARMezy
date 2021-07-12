// custom form input screen code
// -- see how to pass values

import 'package:flutter/material.dart';
import '../widgets/fertiliser_suggest_form.dart';

class FertiSuggestFormScreen extends StatefulWidget {
  @override
  FertiSuggestFormScreenState createState() => FertiSuggestFormScreenState();
}

class FertiSuggestFormScreenState extends State<FertiSuggestFormScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Fertiliser Suggestion'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: FertiSuggestForm(),
      ),
    );
  }
}
