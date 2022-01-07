import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/model/shop_item.dart';

import 'catalog_model.dart';

class CartModel extends ChangeNotifier {
  late CatalogModel _catalog;

  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  List<ShopItem> get items => _itemIds.map((e) => _catalog.getById(e)).toList();

  double get totalMoney => items.fold(0, (previousValue, element) => previousValue+element.price);

  void add(ShopItem item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(ShopItem item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }

}
