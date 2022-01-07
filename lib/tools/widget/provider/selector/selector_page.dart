import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("----------整个MyApp被绘制----------");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("MyProviderDemo")),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MyNotifier0()),
            ChangeNotifierProvider(create: (context) => MyNotifier1()),
            ChangeNotifierProvider(create: (context) => MyNotifier2()),
          ],
          child: MyProviderDemo(),
        ),
      ),
    );
  }
}

class MyProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyNotifier0 myNotifier0 = Provider.of<MyNotifier0>(context);
    print("----------整个MyProviderDemo被重绘----------");
    return Column(
      children: <Widget>[
        //使用Provider.of<T>(context)方法来引用数据
        RaisedButton(
          child: Text(myNotifier0.dataInt.toString()),
          onPressed: () {
            myNotifier0.changeData();
          },
        ),
        //使用Consumer方法来引用数据
        //第一个Consumer：
        Consumer(
          builder: (context, value, child) {
            print("----------第一个Consumer被重绘了----------");
            return RaisedButton(
              child: Text("引用而为被使用"),
              onPressed: () {},
            );
          },
        ),
        //第二个Consumer：
        Consumer<MyNotifier1>(
          builder: (context,  value,  child) {
            print("----------第二个Consumer被重绘了----------");
            return RaisedButton(
              child: Text(value.dataInt1.toString()),
              onPressed: () {
                value.changeData1();
              },
            );
          },
        ),
        //第三个Consumer：
        Consumer<MyNotifier1>(
          builder: (context, value, child) {
            print("----------第三个Consumer被重绘了----------");
            return RaisedButton(
              child: Text(value.dataInt2.toString()),
              onPressed: () {
                value.changeData2();
              },
            );
          },
        ),
        //第四个Consumer：
        Consumer<MyNotifier2>(
          builder: (context, value, child) {
            print("----------第四个Consumer被重绘了----------");
            return RaisedButton(
              child: Text(value.dataInt.toString()),
              onPressed: () {
                value.changeData();
              },
            );
          },
        ),
        //第一个Selector:
        Selector<MyNotifier1,MyNotifier1>(
          selector: (context, MyNotifier1 myNotifier1) {
            print("----------第一个Selector中的selector被重执行了----------");
            return myNotifier1;
          },
          builder: (context, myNotifier1, child) {
            print("----------第一个Selector中的builder被重绘了----------");
            return RaisedButton(
              child: Text(myNotifier1.dataInt1.toString()),
              onPressed: () {
                myNotifier1.changeData1();
              },
            );
          },
        ),
        //第二个Selector:
        Selector<MyNotifier1,MyNotifier1>(
          selector: (BuildContext context, MyNotifier1 myNotifier1) {
            print("----------第二个Selector中的selector被重执行了----------");
            return myNotifier1;
          },
          builder: (BuildContext context, myNotifier1, child) {
            print("----------第二个Selector中的builder被重绘了----------");
            return RaisedButton(
              child: Text(myNotifier1.dataInt1.toString()),
              onPressed: () {
                myNotifier1.changeData1();
              },
            );
          },
        ),
        //第三个Selector:
        Selector<MyNotifier1,int>(
          selector: (BuildContext context, MyNotifier1 myNotifier1) {
            print("----------第三个Selector中的selector被重执行了----------");
            return myNotifier1.dataInt1;
          },
          builder: (context, dataInt1, child) {
            print("----------第三个Selector中的builder被重绘了----------");
            return RaisedButton(
              child: Text(dataInt1.toString()),
              onPressed: () {},
            );
          },
        ),
        //第四个Selector:
        Selector<MyNotifier1,List>(
          selector: (BuildContext context, myNotifier1) {
            print("----------第四个Selector中的selector被重执行了----------");
            return [myNotifier1.dataInt1, myNotifier1.changeData1];
          },
          builder: (context, list, child) {
            print("----------第四个Selector中的builder被重绘了----------");
            return RaisedButton(
              child: Text(list[0].toString()),
              onPressed: () {
                list[1]();
              },
            );
          },
        )
      ],
    );
  }
}

class MyNotifier0 with ChangeNotifier {
  int dataInt = 0;
  void changeData() {
    dataInt++;
    notifyListeners();
  }
}

class MyNotifier1 with ChangeNotifier {
  int dataInt1 = 0;
  int dataInt2 = 0;
  void changeData1() {
    dataInt1++;
    notifyListeners();
  }

  void changeData2() {
    dataInt2++;
    notifyListeners();
  }
}

class MyNotifier2 with ChangeNotifier {
  int dataInt = 0;
  void changeData() {
    dataInt++;
    notifyListeners();
  }
}