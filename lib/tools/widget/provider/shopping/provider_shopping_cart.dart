import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/catalog.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/login.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/shopping_cart.dart';
import 'package:provider/provider.dart';

import 'model/cart_model.dart';
import 'model/catalog_model.dart';

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CatalogModel(),
        ),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart!.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: "购物车",
        initialRoute: "/",
        theme: ThemeData.light(),
        routes: {
          "/": (context) {
            return LoginPage();
          },
          "/catalog": (context) {
            return CatalogPage();
          },
          "/shopping_cart": (context) {
            return ShoppingCartPage();
          },
        },
      ),
    );
  }
}
