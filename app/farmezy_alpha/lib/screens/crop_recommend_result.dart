// custom feature output screen code
// can try to pass positional args to this class()
// from crop rec form dart file
// and then pass all values to firebase ml kit
// then create state acc to ml model output returned

import 'package:flutter/material.dart';
import '../providers/yield_list.dart';

class CropRecRes extends StatefulWidget {
  // const CropRecRes({ Key? key }) : super(key: key);

  @override
  _CropRecResState createState() => _CropRecResState();
}

class _CropRecResState extends State<CropRecRes> {
  int _resultIndex = 2;
  List<int> _resultarray = [2, 6, 8, 10, 15, 20];

  String _showresult(List<int> value) {
    String blank = '';
    for (int i = 0; i < value.length; i++) {
      blank = blank + ' \n ' + crops[value[i]];
    }
    return blank;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Crop Recommendation Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Crops Recommended For You: \n'),
            //Text(cropsdata(_resultIndex).toString()),
            Text(_showresult(_resultarray)),
            //_resultIndex.map((index) { Text(cropsdata(index).toString())};),),
          ],
        ), //... builderfunc(),
      ),
    );
  }
}
