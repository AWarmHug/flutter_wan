import 'package:flutter/material.dart';

class ShopItem {
  final int id;
  final String name;
  final double price;
  final Color color;

  ShopItem(this.id, this.name, this.price) : color = Colors.primaries[id];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
