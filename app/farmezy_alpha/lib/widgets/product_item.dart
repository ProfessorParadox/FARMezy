import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final double price;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final token= Provider.of<Auth>(context,listen: false).token;
    final u_id=Provider.of<Auth>(context,listen:false).uId;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                    icon: Icon(
                        product.isFav ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFav(product.id,token,u_id);
                    },
                    color: Colors.teal[700],
                  )),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.teal[700],
                content: Text('Item Added to Cart'),
                duration: Duration(seconds: 1),
                action: SnackBarAction(label: 'Undo',
                textColor: Colors.white,
                onPressed: (){
                  cart.removeSingleItem(product.id);
                },),
              ));
            },
            color: Colors.teal[700],
          ),
        ),
      ),
    );
  }
}
