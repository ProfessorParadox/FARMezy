// custom feature output screen code

import 'package:flutter/material.dart';
import '../providers/fertiliser_list.dart' show fertidata;

class FertiSuggestRes extends StatefulWidget {
  // const FertiSuggestRes({ Key? key }) : super(key: key);

  @override
  _FertiSuggestResState createState() => _FertiSuggestResState();
}

class _FertiSuggestResState extends State<FertiSuggestRes> {
  int _resultIndex = 2;
  final List<String> _result = [
    'NHigh',
    'NLow',
    'PHigh',
    'PLow',
    'KHigh',
    'KLow',
  ];

  //... calling code for ML model
  // answer received in result_index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fertiliser Suggestion Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Text(
            fertidata(_result[_resultIndex]).toString()), //... builderfunc(),
      ),
    );
  }
}
