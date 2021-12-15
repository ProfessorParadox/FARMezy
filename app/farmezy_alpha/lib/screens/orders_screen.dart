

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order-Screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero).then((_) async {
      setState(() {
      _isloading=true;  
      }); 
      

     Provider.of<Orders>(context,listen:false).fetchAndSetOrders();
    setState(() {
      _isloading = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isloading== true ?  Center(child: CircularProgressIndicator()) : 
       ordersData.orders.length==0 ?  Center(child: Text('Buy something first!!'),) :      
           ListView.builder(
                      itemBuilder: (ctx, i) {
                        return OrderItem(ordersData.orders[i]);
                      },
                      itemCount: ordersData.orders.length,
    ) );
  }     }    
