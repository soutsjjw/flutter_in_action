import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text('open new route'),
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () async {
                  await Navigator.pushNamed(context, "new_page");
                  /*
                  await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewRoute();
                  }));
                  */
                },
              ),
              ElevatedButton(
                child: Text('打開提示頁'),
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return TipRoute(text: "我是提示xxxx");
                    }),
                  );
                  print("路由回傳值：$result");
                },
              ),
              OutlinedButton(
                child: Text('命名路由参数传递'),
                onPressed: () async {
                  Navigator.of(context).pushNamed("echo_route", arguments: "hi");
                },
              ),
            ],
          ),
        ]);
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text // 接收一個text參數
      })
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是回傳值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("接收到的參數：$args"),
            ],
          ),
        ),
      ),
    );
  }
}
