import 'package:flutter/material.dart';

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context測試"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget樹中向上查找最近的父級`Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接回傳AppBar的title，此處實際上是Text("Context測試")
          return (scaffold.appBar as AppBar).title;
        },),
      ),
    );
  }
}
