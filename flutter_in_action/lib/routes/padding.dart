import 'package:flutter/material.dart';

class PaddingTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // 上下左右各添加16像素補白
      padding: EdgeInsets.all(16.0),
      child: Column(
        // 顯式指定對齊方式為左對齊，排除對齊干擾
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            // 左邊添加8像素補白
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Hello world"),
          ),
          Padding(
            // 上下各添加8像素補白
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("I am Jack"),
          ),
          Padding(
            // 分別指定四個方向的補白
            padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}
