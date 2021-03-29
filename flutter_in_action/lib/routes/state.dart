import 'package:flutter/material.dart';

class RetrieveStateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("子樹中獲取State對象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              // 查找父級最近的Scaffold對應的ScaffoldState對象
              // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
              // 直接通過of靜態方法來獲取ScaffoldState
              ScaffoldState _state = Scaffold.of(context);
              _state.showSnackBar(
                SnackBar(content: Text("我是SnackBar"),)
              );
            },
            child: Text("顯示SnackBar"),
          );
        },),
      ),
    );
  }
}
