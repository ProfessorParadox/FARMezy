import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String productId;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 15),
        margin: EdgeInsets.all(5),
        color: Theme.of(context).errorColor,
        child: Row(
          children: <Widget>[
            Text(
              'Delete',
              style: Theme.of(context).textTheme.headline6,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  title: Text('Are you Sure??',style: TextStyle(color: Colors.black),),
                  content:
                      Text('Do you want to remove this item from the cart?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Yes',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                    ),
                    FlatButton(
                      child: Text('No',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),),
                      onPressed: (){
                        Navigator.of(ctx).pop(false);
                      },
                    )
                  ],
                ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  productData.productImage(title),
                  width: 50,
                  fit: BoxFit.cover,
                )),
            title: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Price : \₹$price  Quantity : $quantity'),
            trailing: Text(
              'Total : \₹${price * quantity}',
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
