import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

import './cart_screen.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFav = false;
  var _isInit = true;
  var _isLoading =false;

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero).then((value){
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading=false;
        });
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shop App'),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, childwidget) => Badge(
                child: childwidget,
                value: cart.totalQuantity.toString(),
              ),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  }),
            ),
            PopupMenuButton(
              onSelected: (FilterOptions val) {
                setState(() {
                  if (val == FilterOptions.Favourites) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                      child: Text('Show Favourites'),
                      value: FilterOptions.Favourites),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ];
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading ?  Center(child: CircularProgressIndicator(),)    :  ProductGrid(_showOnlyFav));
  }
}
