// custom feature output screen code
// can try to pass positional args to this class()
// from crop rec form dart file
// and then pass all values to firebase ml kit
// then create state acc to ml model output returned

//import 'dart:ffi';
import 'dart:io';

import '../providers/yield_predict_provider.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yield_list.dart';

class CropRecRes extends StatefulWidget {
  // const CropRecRes({ Key? key }) : super(key: key);
  static const routeName = '/crop-recommendation-screen';

  @override
  _CropRecResState createState() => _CropRecResState();
}

class _CropRecResState extends State<CropRecRes> {
  /* int _resultIndex = 2;
  List<int> _resultarray = [2, 6, 8, 10, 15, 20];

  String _showresult(List<int> value) {
    String blank = '';
    for (int i = 0; i < value.length; i++) {
      blank = blank + ' \n ' + crops[value[i]];
    }
    return blank;
  }
*/
  @override
  Widget build(BuildContext context) {
    final recommendedCrop = Provider.of<YieldData>(context, listen: false).crop;
    final cropImageUrl = Provider.of<YieldData>(context, listen: false).cropUrl;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Crop Recommendation Result'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Crops Recommended For You: \n',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            //Text(cropsdata(_resultIndex).toString()),
            /* Text(_showresult(_resultarray)), */
            SizedBox(
              height: 20,
            ),
            //_resultIndex.map((index) { Text(cropsdata(index).toString())};),),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                //height: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(
                  cropImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              recommendedCrop,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal[700]),
            ),
          ],
        ), //... builderfunc(),
      ),
      drawer: AppDrawer(),
    );
  }
}
