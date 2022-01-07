import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'model/cart_model.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          CartModel cart = context.read();
          return Text("总价：${cart.totalMoney}");
        }),
      ),
      body: Container(
        child: Builder(builder: (context) {
          CartModel cart = context.read();
          return ListView.separated(
              itemBuilder: (context, index) {
                return Text(cart.items[index].name);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12,
                );
              },
              itemCount: cart.items.length);
        }),
      ),
    );
  }
}
