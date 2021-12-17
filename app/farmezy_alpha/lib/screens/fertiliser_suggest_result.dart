// custom feature output screen code

import 'package:flutter/material.dart';
import '../providers/fertiliser_list.dart' show fertidata;
import '../widgets/app_drawer.dart';

class FertiSuggestRes extends StatefulWidget {
  // const FertiSuggestRes({ Key? key }) : super(key: key);
  static const routeName = '/fertilizer-suggest-screen';

  @override
  _FertiSuggestResState createState() => _FertiSuggestResState();
}

class _FertiSuggestResState extends State<FertiSuggestRes> {
 
 
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
    
  final data= ModalRoute.of(context).settings.arguments as Map<String,String>;
  final _n=data['n'];
  final _p=data['p'];
  final _k=data['k'];
  int _resultIndex=int.parse(_n)+int.parse(_p)+int.parse(_k);
  _resultIndex=(_resultIndex/3).floor();
  print(_resultIndex);
  _resultIndex=_resultIndex%5;
  print(_resultIndex);
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fertiliser Suggestion Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
                fertidata(_result[_resultIndex]).toString(),style: TextStyle(fontSize: 20),), //... builderfunc(),
          ),
        ],
      ),
      ),
    );
  }
}
