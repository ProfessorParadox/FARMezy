// custom form input screen code
// make form widget stateless and return form() from there
// and also buildnpk() defs
// make this screen stateful and return scaffold with child as form()
// which is imported from folder of widgets
// -- see how to pass values

import 'package:farmezy_alpha/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/crop_recommend_form.dart';

class CropRecFormScreen extends StatefulWidget {
  static const routeName = '/Crop-Recommend-Screen';
  @override
  CropRecFormScreenState createState() => CropRecFormScreenState();
}

class CropRecFormScreenState extends State<CropRecFormScreen> {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Crop Recommendation'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: CropRecForm(),
      ),
      drawer:AppDrawer(),
    );
  }
}
