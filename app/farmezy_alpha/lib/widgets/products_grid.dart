import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final showOnlyFav;
  ProductGrid(this.showOnlyFav);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =showOnlyFav ? productData.favItems  : productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            childAspectRatio: 2 / 2.5,
            crossAxisSpacing: 10),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(
              // products[index].id, 
              // products[index].title,
              // products[index].imageUrl,
              // products[index].price
              ),
          );
        });
  }
}
