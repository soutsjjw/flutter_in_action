import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 頭像
    Widget avatar = Image.asset("images/avatar.png", width: 60.0);
    return Center(
      child: Column(
        children: <Widget>[
          avatar, // 不剪裁
          ClipOval(
            child: avatar,
          ), // 剪裁為圓形
          ClipRRect(
            // 剪裁為圓角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5, // 寬度設為原來寬度一半，另一半會溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, // 寬度設為原來寬度一半
                  child: avatar,
                ),
              ),
              Text("你好世界", style: TextStyle(color: Colors.green)),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: ClipRRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) => RRect.fromLTRBR(10.0, 15.0, 30.0, 15.0, Radius.circular(5));

  // RRect.fromLTRBR(double left, double top, double right, double bottom, Radius radius)

  // Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  // const Rect.fromLTWH(double left, double top, double width, double height) : this.fromLTRB(left, top, left + width, top + height);

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => false;
}
