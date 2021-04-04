import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//#region 拖動（任意方向）

class DragTestRoute extends StatefulWidget {
  @override
  _DragTestRouteState createState() => _DragTestRouteState();
}

class _DragTestRouteState extends State<DragTestRoute>
    with SingleTickerProviderStateMixin {
  double _top = 0.0; //距頂部的偏移
  double _left = 0.0; //距左邊的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            //手指按下時會觸發此回調
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相對於屏幕)
              print("用戶手指按下：${e.globalPosition}");
            },
            //手指滑動時會觸發此回調
            onPanUpdate: (DragUpdateDetails e) {
              //用戶手指滑動時，更新偏移，重新構建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑動結束時在x、y軸上的速度
              print(e.velocity);
            },
          ),
        ),
      ],
    );
  }
}

//#endregion

//#region 單一方向拖動

class DragVertical extends StatefulWidget {
  @override
  _DragVerticalState createState() => _DragVerticalState();
}

class _DragVerticalState extends State<DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            //垂直方向拖動事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
          ),
        ),
      ],
    );
  }
}

//#endregion

//#region 縮放

class ScaleTestRouteState extends StatefulWidget {
  @override
  _ScaleTestRouteStateState createState() => _ScaleTestRouteStateState();
}

class _ScaleTestRouteStateState extends State<ScaleTestRouteState> {
  double _width = 200.0; //通過修改圖片寬度來達到縮放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定寬度，高度自適應
        child: Image.asset("./images/sea.png", width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //縮放倍數在0.8到10倍之間
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

//#endregion

//#region GestureRecognizer

class GestureRecognizerTestRouteState extends StatefulWidget {
  @override
  _GestureRecognizerTestRouteStateState createState() =>
      _GestureRecognizerTestRouteStateState();
}

class _GestureRecognizerTestRouteStateState
    extends State<GestureRecognizerTestRouteState> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //變色開關

  @override
  void dispose() {
    //用到GestureRecognizer的話一定要調用其dispose方法釋放資源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(
        children: [
          TextSpan(text: "你好世界"),
          TextSpan(
            text: "點我變色",
            style: TextStyle(
                fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              },
          ),
          TextSpan(text: "你好世界"),
        ],
      )),
    );
  }
}

//#endregion

//#region 手勢競爭

class BothDirectionTestRoute extends StatefulWidget {
  @override
  _BothDirectionTestRouteState createState() => _BothDirectionTestRouteState();
}

class _BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            //垂直方向拖動事件
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        ),
      ],
    );
  }
}

//#endregion

class GestureConflictTestRouteState extends StatefulWidget {
  @override
  _GestureConflictTestRouteStateState createState() =>
      _GestureConflictTestRouteStateState();
}

class _GestureConflictTestRouteStateState
    extends State<GestureConflictTestRouteState> {
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            //要拖動和點擊的widget
            child: CircleAvatar(child: Text("A")),
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details){
              print("onHorizontalDragEnd");
            },
            onTapDown: (details){
              print("down");
            },
            onTapUp: (details){
              print("up");
            },
          ),
        ),
        Positioned(
          top: 80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //會觸發
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        ),
      ],
    );
  }
}
