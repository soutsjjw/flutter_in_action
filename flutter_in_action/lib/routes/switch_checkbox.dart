import 'package:flutter/material.dart';

class SwitchAndCheckBoxRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxRouteState createState() => _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true; // 維護單選開關狀態
  bool _checkboxSelected = true; // 維護複選框狀態

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Switch(
                value: _switchSelected,
                onChanged: (value) {
                  // 重新構建頁面
                  setState(() {
                    _switchSelected = value;
                  });
                }),
            Text("關"),
            Switch(value: !_switchSelected, onChanged: (value) {}),
            Text("開"),
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
                value: _checkboxSelected,
                activeColor: Colors.red, // 選中時的顏色
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value;
                  });
                }),
            Text("未選中"),
            Checkbox(
                value: !_checkboxSelected,
                activeColor: Colors.red, // 選中時的顏色
                onChanged: (value) {}),
            Text("選中"),
          ],
        ),
      ],
    );
  }
}
