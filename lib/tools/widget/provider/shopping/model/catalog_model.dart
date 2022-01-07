import 'package:flutter_wan/tools/widget/provider/shopping/model/shop_item.dart';

class CatalogModel {
  static List<ShopItem> items = [
    ShopItem(0, "冰淇淋", 2.0),
    ShopItem(1, "西瓜", 20.0),
    ShopItem(2, "蓝莓", 12.0),
    ShopItem(3, "辣条", 1.0),
    ShopItem(4, "烤翅", 8.0),
    ShopItem(5, "烤肠", 4.0),
    ShopItem(6, "火龙果", 5.0),
    ShopItem(7, "拖鞋", 12.0),
    ShopItem(8, "篮球", 50.0),
    ShopItem(9, "足球", 58.0),
    ShopItem(10, "乒乓球", 5.0),
    ShopItem(11, "羽毛球", 5.0),
    ShopItem(12, "篮球鞋", 258.0),
    ShopItem(13, "足球鞋", 258.0),
    ShopItem(14, "牛肉干", 58.0),
    ShopItem(15, "饼干", 18.0),
    ShopItem(16, "面包", 8.0),
    ShopItem(17, "牛仔外套", 358.0),

  ];

  ShopItem getById(int id) {
    return items[id];
  }
}
