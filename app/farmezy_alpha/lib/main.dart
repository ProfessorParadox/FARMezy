import 'package:farmezy_alpha/providers/yield_predict_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import './providers/yield_predict_provider.dart';
import '../screens/crop_recommend.dart';
import '../screens/fertiliser_suggest.dart';
import '../screens/yield_predict.dart';
import '../screens/fertiliser_suggest_result.dart';
import '../screens/crop_recommend_result.dart';
import '../screens/yield_predict_result.dart';

import './screens/auth_screen.dart';
import './screens/user_products_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splashScreen.dart';

import './providers/orders.dart';
import './providers/products.dart';
import './providers/cart.dart';
import 'providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, previousOrders) =>
              previousOrders..updateData(auth.token, auth.uId),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previousProducts) => previousProducts
            ..update(
                auth.token,
                previousProducts == null ? [] : previousProducts.items,
                auth.uId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx)=>YieldData(),),

        ],
        child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Shop App',
            theme: ThemeData(
                primarySwatch: Colors.teal,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(color: Colors.white, fontSize: 18),
                    )),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryLogin(),
                    builder: (ctx, authDataSnapshot) =>
                        authDataSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              DashboardScreen.routeName: (ctx)=>DashboardScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              FertiSuggestRes.routeName: (ctx) => FertiSuggestRes(),
              YieldPredictFormScreen.routeName: (ctx) =>
                  YieldPredictFormScreen(),
              FertiSuggestFormScreen.routeName: (ctx) =>
                  FertiSuggestFormScreen(),
              CropRecFormScreen.routeName: (ctx) => CropRecFormScreen(),
              YieldPredictRes.routeName: (ctx) => YieldPredictRes(),
              CropRecRes.routeName: (ctx) => CropRecRes(),
            }),
            ),
    );
  }
}
