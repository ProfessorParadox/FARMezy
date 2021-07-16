import 'package:flutter/material.dart';

import '../screens/crop_recommend.dart';
import '../screens/yield_predict.dart';
import '../screens/fertiliser_suggest.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello!'),
            automaticallyImplyLeading: false,
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Yield Predict'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed(YieldPredictFormScreen.routeName);
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Crop Recommend'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed(CropRecFormScreen.routeName);
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Fertilizer Suggest'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed(FertiSuggestFormScreen.routeName);
            },
          ),

        ],
      )
      
    );
  }
}