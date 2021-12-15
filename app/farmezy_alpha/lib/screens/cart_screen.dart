import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

import '../widgets/cart_item.dart';

import './orders_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart',
              style: TextStyle(
                fontSize: 20,
              )),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: cartData.totalQuantity==0 ?Center(child: Text('Add something is your cart first!'),) : ListView.builder(
                itemBuilder: (ctx, index) {
                  return CartItem(
                      cartData.items.values.toList()[index].id,
                      cartData.items.keys.toList()[index],
                      cartData.items.values.toList()[index].title,
                      cartData.items.values.toList()[index].price,
                      cartData.items.values.toList()[index].quantity);
                },
                itemCount: cartData.itemCount,
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Chip(
                      label: Text(
                          '\₹ ${cartData.totalPrice.toStringAsFixed(3)}',
                          style: Theme.of(context).textTheme.headline6),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Spacer(),
                    OrderButton(cartData: cartData),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() :Text(
        'Order Now',
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () async {
        if (widget.cartData.totalQuantity == 0) {
          showDialog(
              context: context,
              builder: (_)=> AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                title: Text('Error',textAlign: TextAlign.center,
                    style: TextStyle(
                        color:Colors.black,
                        fontSize: 20)),
                        content: Text('Your Cart is Empty',textAlign: TextAlign.center,style:TextStyle(color:Theme.of(context).primaryColor,fontSize: 15),),
              ));
        } else {
          setState(() {
            _isLoading=true;
          });
          // ignore: await_only_futures
          await Provider.of<Orders>(context, listen: false).addOrder(
              widget.cartData.items.values.toList(),
              widget.cartData.totalPrice);
              setState(() {
                _isLoading=false;
              });

          widget.cartData.clear();
          Navigator.of(context)
              .pushReplacementNamed(OrdersScreen.routeName);
        }
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
