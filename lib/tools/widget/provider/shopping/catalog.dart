import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/model/catalog_model.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/model/shop_item.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'model/cart_model.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/shopping_cart");
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return _ListItem(index: index);
          },
          itemCount: CatalogModel.items.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {

    // bool isInCart = context.select<CartModel,bool>((value) {
    //   return value.items.contains(item);
    // });

    return Selector<CatalogModel, ShopItem>(
      selector: (context, catalog) {
        return catalog.getById(index);
      },
      builder: (context, item, child) {
        debugPrint("----------1");
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Builder(builder: (context) {
                debugPrint("----------2");
                return Container(
                  width: 48,
                  height: 48,
                  color: item.color,
                );
              }),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Selector<CartModel, bool>(
                selector: (context, cart) {
                  return cart.items.contains(item);
                },
                builder: (context, isInCart, child) {
                  return  IconButton(
                    onPressed: !isInCart
                        ? () {
                      CartModel cart = context.read();
                      cart.add(item);
                    }
                        : null,
                    icon: Builder(builder: (context) {
                      debugPrint("----------3");
                      return Icon(!isInCart ? Icons.add : Icons.done);
                    }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
