import 'dart:math' as math;
import 'package:flutter/material.dart';

class TransformTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight,
              transform: new Matrix4.skewY(0.3),
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text("Apartment for rent!"),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            // 默認原點為左上角，左移20像素，向上平移5像素
            child: Transform.translate(
              offset: Offset(-20.0, -5.0),
              child: Text("Hello world"),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              // 旋轉90度
              angle: math.pi / 2,
              child: Text("Hello world"),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5, // 放大到1.5倍
              child: Text("Hello world"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                  scale: 1.5, // 放大到1.5倍
                  child: Text("Hello world"),
                ),
              ),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                // 將Transform.rotate換成RotatedBox
                child: RotatedBox(
                  quarterTurns: 1,  // 旋轉90度
                  child: Text("Hello world"),
                ),
              ),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              ),
            ],
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
