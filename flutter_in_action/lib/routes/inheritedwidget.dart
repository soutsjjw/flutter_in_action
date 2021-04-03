import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(),
            ),
            ElevatedButton(
              child: Text("Increment"),
              // 每點擊一次，將count自增，然後重新build,ShareDataWidget的data將被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  // 定義一個便捷方法，方便子樹中的widget獲取共享數據
  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 該回調決定當data發生變化時，是否通知子樹中依賴data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，則子樹中依賴(build函數中有調用)本widget
    //的子widget的`state.didChangeDependencies`會被調用
    return old.data != data;
  } // 需要在子樹中共享的數據，保存點擊次數
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // 使用InheritedWidget中的共享數據
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改變(updateShouldNotify返回true)時會被調用。
    //如果build中沒有依賴InheritedWidget，則此回調不會被調用。
    print("Dependencies change");
  }
}
