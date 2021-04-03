// 一個通用的InheritedWidget，保存任需要跨組件共享的狀態
import 'package:flutter/material.dart';

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  // 定義一個便捷方法，方便子樹中的widget獲取共享數據
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果數據發生變化（model類調用了notifyListeners），重新構建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 當Provider更新時，如果新舊數據不"=="，則解綁舊數據監聽，同時添加新數據監聽
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 給model添加監聽器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的監聽器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 一個通用的InheritedWidget，保存任需要跨組件共享的狀態
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  // 共享狀態使用泛型
  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget old) {
    // 在此簡單返回true，則每次更新都會調用依賴其的子孫節點的`didChangeDependencies`。
    return true;
  }
}

// 這是一個便捷類，會獲得當前context和指定數據類型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      // 自動獲取Model
      ChangeNotifierProvider.of<T>(context),
    );
  }
}
