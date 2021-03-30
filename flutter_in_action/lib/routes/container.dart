import 'package:flutter/material.dart';

class ContainerTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.0, left: 120.0),
          // 容器外填充
          constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
          // 卡片大小
          decoration: BoxDecoration(
            // 背景裝飾
            gradient: RadialGradient(
                // 背景徑向漸變
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: .98),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          // 卡片傾斜變換
          transform: Matrix4.rotationZ(.2),
          // 卡片內文字居中
          alignment: Alignment.center,
          child: Text(
            "5.20",
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
        SizedBox(height: 40.0,),
        Container(
          margin: EdgeInsets.all(20.0), // 容器外補白
          color: Colors.orange,
          child: Text("Hello world!"),
        ),
        SizedBox(height: 40.0,),
        Container(
          padding: EdgeInsets.all(20.0), // 容器內補白
          color: Colors.orange,
          child: Text("Hello world!"),
        ),
      ],
    );
  }
}
