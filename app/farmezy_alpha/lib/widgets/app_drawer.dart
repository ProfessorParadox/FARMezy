import 'package:farmezy_alpha/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/crop_recommend.dart';
import '../screens/yield_predict.dart';
import '../screens/fertiliser_suggest.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

import '../providers/auth.dart';

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
            leading: Icon(Icons.dashboard_rounded),
            title: Text('DashBoard'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shop'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Your Products'), 
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'), 
            onTap: (){
              // Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context,listen: false).logout();
            },
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