import 'package:flutter/material.dart';

class WrapTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("A"),
            ),
            label: new Text("Hamilton"),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("M"),
            ),
            label: new Text("Lafayette"),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("H"),
            ),
            label: new Text("Mulligan"),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("J"),
            ),
            label: new Text("Laurens"),
          ),
        ],
      ),
    );
  }
}

class FlowTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
      children: <Widget>[
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.red,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.green,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.blue,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.yellow,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.brown,
        ),
        new Container(
          width: 80.0,
          height: 80.0,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  TestFlowDelegate({this.margin});

  EdgeInsets margin = EdgeInsets.zero;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 計算每一個子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.left;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 繪製子widget（有優化）
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

}
