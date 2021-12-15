import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  // final String title;
  // ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              height: 300,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  loadedProduct.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Price ₹: ${loadedProduct.price}',
                  style: TextStyle(fontSize: 20),
                ),
                
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(10)), ),

              child: TextButton(
                  child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                    //icon: Icon(Icons.shopping_cart,color: Colors.teal[700],),
                    onPressed: () {
                      cart.addItem(loadedProduct.id, loadedProduct.price,
                          loadedProduct.title);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                     // Scaffold.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Item Added to Cart'),
                        duration: Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            cart.removeSingleItem(loadedProduct.id);
                          },
                        ),
                      ));
                    },
                    
                  ),
            ),
            Divider(),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
