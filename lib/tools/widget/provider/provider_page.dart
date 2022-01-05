import 'package:flutter/material.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Builder(
                    builder: (context) {
                      CartModel model = ChangeNotifierProvider.of(context);
                      return Text("总价 = ${model.total}");
                    },
                  ),
                  Builder(
                    builder: (context) {
                      print("ElevatedButton build");
                      return ElevatedButton(
                        onPressed: () {
                          ChangeNotifierProvider.of<CartModel>(context)
                              .add(Item("乒乓球拍", 20.0, 1));
                        },
                        child: Text("添加商品"),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final T data;


  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider(
      {Key? key, required this.data, required this.child})
      : super(key: key);

  final T data;
  final Widget child;

  static T of<T>(BuildContext context) {
    InheritedProvider<T>? provider =
        context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    assert(provider != null, "provider == null");
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return InheritedProvider(data: widget.data, child: widget.child);
  }

  void update() {
    setState(() {});
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }
}

class Item {
  Item(this.name, this.price, this.count);

  String name;
  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  double get total {
    return _items.fold(
        0,
        (previousValue, element) =>
            previousValue + element.count * element.price);
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}
