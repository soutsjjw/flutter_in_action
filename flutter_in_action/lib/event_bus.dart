//訂閱者回調簽名
import 'dart:html';

typedef void EventCallback(arg);

class EventBus {
  //私有構造函數
  EventBus._internal();

  //保存單例
  static EventBus _singleton = new EventBus._internal();

  //工廠構造函數
  factory EventBus() => _singleton;

  //保存事件訂閱者隊列，key:事件名(id)，value: 對應事件的訂閱者隊列
  var _emap = Map<Object, List<EventCallback>>();

  //添加訂閱者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName].add(f);
  }

  //移除訂閱者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //觸發事件，事件觸發後該事件所有訂閱者會被調用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length -1;
    //反向遍歷，防止訂閱者在回調中移除自身帶來的下標錯位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }

  //定義一個top-level（全局）變量，頁面引入該文件後可以直接使用bus
  var bus = new EventBus();
}
