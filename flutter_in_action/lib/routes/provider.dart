import 'dart:collection';

import 'package:flutter/material.dart';
import '../provider.dart';

class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Consumer<CartModel>(
                builder: (context, cart) => Text("總價: ${cart.totalPrice}")
              ),
              Builder(
                builder: (context) {
                  print("RaisedButton build");
                  return ElevatedButton(
                      child: Text("添加商品"),
                      onPressed: () {
                        // 給購物車中添加商品，添加後總價會更新
                        ChangeNotifierProvider.of<CartModel>(context, listen: false)
                            .add(Item(20.0, 1));
                      });
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CartModel extends ChangeNotifier {
  // 用於保存購物車中商品列表
  final List<Item> _items = [];

  // 禁止改變購物車裡的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 購物車中商品的總價
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 將 [item] 添加到購物車。這是唯一一種能從外部改變購物車的方法。
  void add(Item item) {
    _items.add(item);
    // 通知監聽器（訂閱者），重新構建InheritedProvider， 更新狀態。
    notifyListeners();
  }
}

class Item {
  Item(this.price, this.count);

  double price; //商品單價
  int count; // 商品份數
}
