import 'package:flutter/material.dart';

class ButtonRoute extends StatefulWidget {
  @override
  _ButtonRouteState createState() => _ButtonRouteState();
}

class _ButtonRouteState extends State<ButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text("normal"),
          onPressed: () {},
        ),
        TextButton(
          child: Text("normal"),
          onPressed: () {},
        ),
        OutlinedButton(child: Text("normal"), onPressed: () {}),
        IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
        ElevatedButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.send), label: Text("發送")),
        OutlinedButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.add), label: Text("添加")),
        TextButton.icon(
            onPressed: _onPressed, icon: Icon(Icons.info), label: Text("詳情")),
        TextButton(
          onPressed: () {},
          child: Text("Submit"),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            onSurface: Colors.red,
            shadowColor: Colors.yellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          ),
        ),
      ].map((e){
        return Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 100,
                child: e,
              ),
            ),
            Text(e.runtimeType.toString())
          ],
        );
      }).toList(),
    );
  }

  void _onPressed() {
    print("button pressed");
  }
}
